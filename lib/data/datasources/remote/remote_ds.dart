import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project/data/models/calculation_response.dart';

class RemoteDataSource {
  static bool trustSelfSigned = true;
  static HttpClient get httpClient => HttpClient()
    ..connectionTimeout = const Duration(seconds: 100)
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);

  static String get baseUrl => 'https://p42t4p38-8000.asse.devtunnels.ms';

  // Stream<String> processTest(String filePath) async* {
  //   final url = Uri.parse(baseUrl);
  //   final x = await httpClient.getUrl(url);
  //   final y = await x.close();
  //   final z = await readResponseAsString(y);
  //   print(z);
  // }

  Stream<CalculationResponseWithMessage> process(
    String filePath,
    double refLength,
  ) async* {
    final url = Uri.parse('$baseUrl/detect');
    // final x = await httpClient.postUrl(url);
    // final y = await x.close();
    // final z = await readResponseAsString(y);
    // print(z);

    final requestMultipart = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('photo', filePath);
    requestMultipart.files.add(file);
    requestMultipart.fields['refLength'] = refLength.toString();
    final msStream = requestMultipart.finalize();

    final request = await httpClient.postUrl(url);
    request.contentLength = requestMultipart.contentLength;
    request.headers.set(
      HttpHeaders.contentTypeHeader,
      requestMultipart.headers[HttpHeaders.contentTypeHeader]!,
    );
    request.headers.set('Connection', 'keep-alive');
    // request.headers.set('Keep-Alive', 'timeout=50, max=10');

    // Upload file
    yield (message: 'Mengupload data', response: null);
    await request.addStream(msStream);

    // Memproses file
    yield (message: 'Memproses data', response: null);
    final response = await request.close();
    // await _delay();

    // Mendapat hasil
    yield (message: 'Menerima hasil perhitungan', response: null);
    final jsonStr = await readResponseAsString(response);
    CalculationResponse result = await compute((jst) async {
      final jsonData = await jsonDecode(jst);
      return (
        success: jsonData['success'] as bool,
        error: jsonData['error'] as String?,
        data: jsonData['data'] != null
            ? (
                height: jsonData['data']['height'] as double,
                annotation: jsonData['data']['annotation'] as String,
              )
            : null,
      );
    }, jsonStr);
    yield (message: '', response: result);
  }

  static Future<String> readResponseAsString(Stream<List<int>> response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
