import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/widgets/appbar.dart';
import 'widgets/end_result.dart';
import 'widgets/process_status.dart';
import 'widgets/take_photo.dart';
import 'controller.dart';

class CalculateView extends GetView<CalculateController> {
  const CalculateView({super.key});

  EasyStep _step(String label, IconData icon, int index) => EasyStep(
        customStep: Icon(
          icon,
          color:
              controller.stepIndex.value > index ? Colors.white : AppTheme.dark,
        ),
        customTitle: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTheme.family.copyWith(
            fontWeight: controller.stepIndex.value == index
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      );

  Widget _content(int index) => switch (index) {
        0 => const TakePhoto(),
        1 => const ProcessStatus(),
        2 => const EndResult(),
        _ => const Placeholder(),
      };

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (didPop) return;
        await controller.onBackInvoked();
      },
      child: Scaffold(
        appBar: appBar(
          title: 'Hitung Tinggi',
          withBack: true,
          onBack: controller.onBackInvoked,
        ),
        body: Column(
          children: [
            Obx(
              () => EasyStepper(
                activeStep: controller.stepIndex.value,
                enableStepTapping: false,
                lineStyle: const LineStyle(
                  lineLength: 50,
                  lineType: LineType.normal,
                  lineThickness: 3,
                  lineSpace: 1,
                  lineWidth: 10,
                  unreachedLineType: LineType.dashed,
                ),
                stepShape: StepShape.rRectangle,
                stepBorderRadius: 15,
                borderThickness: 2,
                internalPadding: 10,
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                stepRadius: 28,
                finishedStepBorderColor: AppTheme.green,
                finishedStepBackgroundColor: AppTheme.green,
                activeStepBorderColor: Colors.amber,
                activeStepBackgroundColor: Colors.amber,
                showLoadingAnimation: false,
                steps: [
                  _step('Ambil gambar', Icons.camera, 0),
                  _step('Proses gambar', Icons.memory_outlined, 1),
                  _step('Hasil', Icons.straighten_outlined, 2),
                ],
                onStepReached: (index) => controller.stepIndex.value = index,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Obx(() {
                  final id = controller.stepIndex.value;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _content(id),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
