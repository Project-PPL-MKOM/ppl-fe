import 'package:get/get.dart';
import 'package:project/di.dart';
import 'package:project/domain/usecases/mark_is_intro_done.dart';
import 'package:project/routes/app_pages.dart';

class LandingController extends GetxController {
  void navigateHome() async {
    final task = await Injector.instance<MarkIsIntroDone>();
    await task();
    Get.offNamed(AppRoutes.home);
  }
}
