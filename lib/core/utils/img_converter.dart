import 'dart:convert';
import 'dart:typed_data';

Uint8List imageFromBase64(String encoded) {
  try {
    final bytes = base64Decode(encoded);
    return bytes;
  } catch (e) {
    return Uint8List(0);
  }
}
