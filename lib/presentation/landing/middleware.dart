import 'package:get/get.dart';
import 'package:project/di.dart';
import 'package:project/domain/usecases/is_intro_done.dart';
import 'package:project/routes/app_pages.dart';

class LandingMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final task = await Injector.instance<IsIntroDone>();
    final isIntroDone = task();
    if (isIntroDone) return GetNavConfig.fromRoute(AppRoutes.home);
    return await super.redirectDelegate(route);
  }
}
