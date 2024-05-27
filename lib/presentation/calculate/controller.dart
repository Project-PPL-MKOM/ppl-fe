import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:project/core/utils/exif.dart';
import 'package:project/core/widgets/dialog.dart';
import 'package:project/di.dart';
import 'package:project/domain/entities/baby_height.dart';
import 'package:project/domain/usecases/add_baby_height.dart';
import 'package:project/domain/usecases/process_data.dart';

class CalculateController extends GetxController {
  final _logger = Logger('CalculateController');
  String babyId = '';
  final stepIndex = 0.obs;

  final imagePath = (null as String?).obs;
  final isCameraIdle = true.obs;

  final message = ''.obs;
  final stepCount = 0.obs;
  final isError = false.obs;

  final annotation = ''.obs;
  final height = 0.0.obs;

  void _parseArgument() {
    dynamic arg = Get.arguments;
    if (arg is String) {
      babyId = arg;
    }
  }

  @override
  void onInit() {
    _parseArgument();
    super.onInit();
  }

  @override
  void onClose() {
    stepIndex.close();
    imagePath.close();
    isCameraIdle.close();
    message.close();
    stepCount.close();
    isError.close();
    super.onClose();
  }

  Future<void> onBackInvoked() async {
    final isDataExist = imagePath.value != null;
    if (!isDataExist) {
      Get.back();
      return;
    }
    bool? confirm = await Get.dialog(const ConfirmDialog());
    if (confirm ?? false) Get.back();
  }

  Future<void> tookPhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      isCameraIdle.value = false;
      if (photo == null) throw Exception('photo is null');
      final rotatedImage = await compute(fixExifRotation, photo.path);
      _logger.info(rotatedImage.path);
      imagePath.value = rotatedImage.path;
    } catch (e, st) {
      _logger.severe('took photo failed', e, st);
    } finally {
      isCameraIdle.value = true;
    }
  }

  void beginProcessing() async {
    stepIndex.value++;

    message.value = '';
    stepCount.value = 0;

    final task = await Injector.instance<ProcessData>();
    // TODO: replace with input data
    const refLength = 30.5;
    final stream = task(imagePath.value ?? '', refLength);
    stream.listen((result) {
      result.fold((error) {
        message.value = error.message;
        isError.value = true;
      }, (calcData) {
        final (message: msg, result: data) = calcData;
        message.value = msg;
        if (data != null) {
          height.value = data.height;
          annotation.value = data.annotation;
        }
        stepCount.value++;
      });
    }, onDone: () {
      if (!isError.value) stepIndex.value++;
    });
  }

  void backToStart() {
    stepIndex.value = 0;
    isError.value = false;
  }

  Future<void> saveData() async {
    final task = await Injector.instance<AddBabyHeight>();
    final newData = BabyHeight.noId(
      babyId: babyId,
      height: height.value,
      timestamp: DateTime.now(),
    );
    final result = await task(newData);
    result.fold((_) {
      Get.snackbar(
        'Simpan data',
        'Data tinggi bayi gagal disimpan',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }, (_) {
      Get.back();
    });
  }
}
