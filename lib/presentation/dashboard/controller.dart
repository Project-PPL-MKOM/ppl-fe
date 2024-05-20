import 'package:get/get.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/routes/app_pages.dart';

class DashboardController extends GetxController {
  final dataProfile = (null as BabyProfile?).obs;

  @override
  void onInit() {
    dynamic arg = Get.arguments;
    if (arg is BabyProfile) {
      dataProfile.value = arg;
    }
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
}
