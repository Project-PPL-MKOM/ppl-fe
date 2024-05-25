import 'package:get/get.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/routes/app_pages.dart';

class DashboardController extends GetxController {
  final dataProfile = (null as BabyProfile?).obs;

  void _parseArgument() {
    dynamic arg = Get.arguments;
    if (arg is BabyProfile) {
      dataProfile.value = arg;
    }
  }

  @override
  void onInit() {
    _parseArgument();
    super.onInit();
  }

  void navigateEditProfile() async {
    final editedData = await Get.toNamed(
      AppRoutes.profile,
      arguments: {'edit': true, 'data': dataProfile.value},
    ) as BabyProfile?;
    if (editedData != null) {
      dataProfile.value = editedData;
    }
  }

  void navigateCalculate() {
    Get.toNamed(AppRoutes.calculate, arguments: dataProfile.value?.id);
  }

  void navigateHistory() {
    Get.toNamed(AppRoutes.history, arguments: dataProfile.value?.id);
  }
}
