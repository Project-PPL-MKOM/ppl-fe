import 'package:get/get.dart';
import 'controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashscreenController());
  }
}
