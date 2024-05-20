import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:project/core/assets/constants.dart';
import 'package:project/core/theme/app_theme.dart';
import 'style.dart';
import 'controller.dart';

class LandingView extends GetView<LandingController> {
  LandingView({super.key});

  final _contentConfigs = [
    ContentConfig(
      pathImage: AppAssets.imgPlan,
      description: 'Temukan Keajaiban Pertumbuhan Bayi Anda',
      styleDescription: descTextStyle.copyWith(color: AppTheme.primary800),
      marginDescription: descTextMargin,
    ),
    ContentConfig(
      pathImage: AppAssets.imgHeightTrend,
      description: 'Bayi Tumbuh Cepat, Kami Membantu Anda Mengikutinya',
      styleDescription: descTextStyle,
      marginDescription: descTextMargin,
    ),
    ContentConfig(
      pathImage: AppAssets.imgBabyMeasure,
      description: 'Cek Tinggi Bayi: Mudah, Akurat, Terpercaya',
      styleDescription: descTextStyle,
      marginDescription: descTextMargin,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        key: UniqueKey(),
        listContentConfig: _contentConfigs,
        renderSkipBtn: Text('Lewati', style: buttonTextStyle),
        renderNextBtn: Text('Lanjut', style: buttonTextStyle),
        renderDoneBtn: Text('Mulai', style: buttonTextStyle),
        indicatorConfig: const IndicatorConfig(
          colorIndicator: AppTheme.grey,
          colorActiveIndicator: AppTheme.primary800,
          typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,
        ),
        scrollPhysics: const BouncingScrollPhysics(),
        onDonePress: controller.navigateHome,
      ),
    );
  }
}
