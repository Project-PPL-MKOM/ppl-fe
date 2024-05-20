import 'package:get/get.dart';
import 'package:project/presentation/dashboard/dashboard.dart';
import 'package:project/presentation/home/home.dart';
import 'package:project/presentation/landing/landing.dart';
import 'package:project/presentation/profile/profile.dart';
import 'package:project/presentation/splashscreen/splashscreen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.root;

  static final routes = [
    GetPage(
      name: AppRoutes.root,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: AppRoutes.landing,
      page: () => LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
