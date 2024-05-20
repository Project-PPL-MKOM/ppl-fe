import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary400,
      body: Center(
        child: SizedBox(
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 1000,
          child: Image.asset('assets/icons/icon-sm.png'),
        ),
      ),
    );
  }
}
