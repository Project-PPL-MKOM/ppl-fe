import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:project/core/assets/constants.dart';
import 'package:project/core/utils/exif.dart';
import 'package:project/core/widgets/dialog.dart';
import 'package:project/di.dart';
import 'package:project/domain/entities/baby_height.dart';
import 'package:project/domain/usecases/add_baby_height.dart';
import 'package:project/domain/usecases/process_data.dart';

class CalculateController extends GetxController {
  final _logger = Logger('CalculateController');
  String babyId = '';
  final activeStepper = 0.obs;

  final imagePath = (null as String?).obs;
  final isReady = true.obs;

  final message = ''.obs;
  final stepCount = 0.obs;

  // TODO: replace with real impelementation
  final annotationPath = AppAssets.imgAnnotation;
  final heightResult = 100.0;

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
    activeStepper.close();
    imagePath.close();
    isReady.close();
    message.close();
    stepCount.close();
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
      isReady.value = false;
      if (photo == null) throw Exception('photo is null');
      final rotatedImage = await compute(fixExifRotation, photo.path);
      _logger.info(rotatedImage.path);
      imagePath.value = rotatedImage.path;
    } catch (e, st) {
      _logger.severe('took photo failed', e, st);
    } finally {
      isReady.value = true;
    }
  }

  void beginProcessing() async {
    activeStepper.value++;

    message.value = '';
    stepCount.value = 0;

    final task = await Injector.instance<ProcessData>();
    final stream = task();
    stream.listen((result) {
      result.fold((_) {
        message.value = 'Terjadi kesalahan';
        stepCount.value = -1;
      }, (msg) {
        message.value = msg;
        stepCount.value++;
      });
    }, onDone: () {
      activeStepper.value++;
    });
  }

  void backToStart() {
    activeStepper.value = 0;
  }

  Future<void> saveData() async {
    final task = await Injector.instance<AddBabyHeight>();
    final newData = BabyHeight.noId(
      babyId: babyId,
      height: heightResult,
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
