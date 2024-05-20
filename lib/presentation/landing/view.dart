import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
// import 'package:onboarding/onboarding.dart';
import 'package:project/core/assets/constants.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/presentation/landing/style.dart';
// import 'package:project/presentation/landing/widgets/board.dart';
// import 'package:project/presentation/landing/widgets/custom_indicator.dart';
import 'controller.dart';

class LandingView extends GetView<LandingController> {
  LandingView({super.key});

  // final _activePainter = Paint()
  //   ..color = Colors.black
  //   ..strokeWidth = 2
  //   ..strokeCap = StrokeCap.round
  //   ..style = PaintingStyle.fill;

  // final _inactivePainter = Paint()
  //   ..color = Colors.grey
  //   ..strokeWidth = 1
  //   ..strokeCap = StrokeCap.round
  //   ..style = PaintingStyle.fill;

  // Material _skipButton(void Function(int) setIndex, int len) => Material(
  //       borderRadius: const BorderRadius.all(Radius.circular(20.0)),
  //       color: const Color.fromARGB(255, 93, 93, 93),
  //       child: InkWell(
  //         borderRadius: const BorderRadius.all(Radius.circular(20.0)),
  //         onTap: () {
  //           controller.boardIndex.value = len - 1;
  //           setIndex(len - 1);
  //         },
  //         child: const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
  //           child: Text(
  //             'Lewati',
  //             style: TextStyle(color: Colors.white, letterSpacing: 1.0),
  //           ),
  //         ),
  //       ),
  //     );

  // Material get _startButton => Material(
  //       borderRadius: const BorderRadius.all(Radius.circular(20.0)),
  //       color: const Color.fromARGB(255, 88, 94, 147),
  //       child: InkWell(
  //         borderRadius: const BorderRadius.all(Radius.circular(20.0)),
  //         onTap: () => controller.navigateHome(),
  //         child: const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
  //           child: Text(
  //             'Mulai',
  //             style: TextStyle(color: Colors.white, letterSpacing: 1.0),
  //           ),
  //         ),
  //       ),
  //     );

  // final _boardList = [
  //   const BoardCard(
  //     asset: AppAssets.imgBabyMeasure,
  //     title: 'Duis ornare libero',
  //     description:
  //         'Suspendisse tincidunt blandit risus, sed aliquam leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae',
  //   ),
  //   const BoardCard(
  //     asset: AppAssets.imgHeightTrend,
  //     title: 'Phasellus rutrum aliquam',
  //     description:
  //         'Nam mi nisl, congue sit amet erat in, pretium fermentum nunc. Phasellus sollicitudin quam eget arcu finibus, ac pharetra arcu',
  //   ),
  // ];

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
    // return Scaffold(
    //   body: Onboarding(
    //     startIndex: 0,
    //     onPageChanges: (_, __, currentIndex, sd) {
    //       controller.boardIndex.value = currentIndex;
    //     },
    //     swipeableBody: _boardList,
    //     buildFooter: (ctx, dragDist, len, curId, setId, direction) =>
    //         DecoratedBox(
    //       decoration: const BoxDecoration(color: Colors.white),
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Indicator<MyCustomIndicatorPainter>(
    //               painter: MyCustomIndicatorPainter(
    //                 currentPageIndex: curId,
    //                 pagesLength: len,
    //                 netDragPercent: dragDist,
    //                 activePainter: _activePainter,
    //                 inactivePainter: _inactivePainter,
    //                 slideDirection: direction,
    //                 lineWidth: 20,
    //               ),
    //             ),
    //             Obx(
    //               () => controller.boardIndex.value == len - 1
    //                   ? _startButton
    //                   : _skipButton(setId, len),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
