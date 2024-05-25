import 'package:get/get.dart';
import 'controller.dart';

class CalculateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalculateController());
  }
}
