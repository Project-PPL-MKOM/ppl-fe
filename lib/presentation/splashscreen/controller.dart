import 'package:get/get.dart';
import 'package:project/di.dart';
import 'package:project/domain/usecases/is_intro_done.dart';
import 'package:project/routes/app_pages.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    final task = await Injector.instance<IsIntroDone>();
    final isIntroDone = task();
    Get.offNamed(isIntroDone ? AppRoutes.home : AppRoutes.landing);
  }
}
