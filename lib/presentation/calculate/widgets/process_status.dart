import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/widgets/button.dart';
import '../controller.dart';

class ProcessStatus extends StatelessWidget {
  const ProcessStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculateController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Obx(
              () => LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                pause: controller.isError.isTrue,
              ),
            ),
          ),
        ),
        Obx(
          () {
            final isError = controller.isError.isTrue;
            final msg = controller.message.value;
            return Text(
              isError
                  ? 'Terjadi kesalahan : $msg'
                  : '$msg (${controller.stepCount.value}/3)',
              textAlign: TextAlign.center,
              style: AppTheme.family.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Obx(
          () {
            final isError = controller.isError.value;
            return isError
                ? actionButton(
                    label: 'Ulangi',
                    color: Colors.red,
                    onPressed: controller.backToStart,
                  )
                : const SizedBox();
          },
        )
      ],
    );
  }
}
