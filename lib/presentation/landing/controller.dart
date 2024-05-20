import 'package:get/get.dart';
import 'package:project/di.dart';
import 'package:project/domain/usecases/mark_is_intro_done.dart';
import 'package:project/routes/app_pages.dart';

class LandingController extends GetxController {
  // final boardIndex = 0.obs;

  // @override
  // void onClose() {
  //   boardIndex.close();
  //   super.onClose();
  // }

  void navigateHome() async {
    final task = await Injector.instance<MarkIsIntroDone>();
    await task();
    // Get.rootDelegate.offNamed(AppRoutes.home);
    Get.offNamed(AppRoutes.home);
  }
}
