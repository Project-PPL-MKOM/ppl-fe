import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:project/core/theme/app_theme.dart';
import '../controller.dart';

class ProcessStatus extends StatelessWidget {
  const ProcessStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculateController>();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SizedBox(
            width: 100,
            height: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
            ),
          ),
        ),
        Obx(
          () => Text(
            '${controller.message.value} (${controller.stepCount.value}/3)',
            style: AppTheme.family.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
