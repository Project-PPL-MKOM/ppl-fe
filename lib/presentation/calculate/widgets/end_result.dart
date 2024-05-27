import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/utils/img_converter.dart';
import 'package:project/core/widgets/button.dart';
import '../controller.dart';

const _width = 210.0;
const _height = _width * 4 / 3;

class EndResult extends StatelessWidget {
  const EndResult({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculateController>();

    return Column(
      children: [
        DottedBorder(
          color: Colors.black,
          strokeWidth: 1,
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: _width,
            height: _height,
            child: Image.memory(
              imageFromBase64(controller.annotation.value),
              width: _width,
              height: _height,
              errorBuilder: (_, e, st) => const Placeholder(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => Text(
            'Tinggi badan : ${controller.height.value.toPrecision(3)} cm',
            textAlign: TextAlign.center,
            style: AppTheme.family
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: actionButton(
                label: 'Ulangi',
                color: AppTheme.red,
                onPressed: controller.backToStart,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: actionButton(
                label: 'Selesai',
                color: AppTheme.primary800,
                onPressed: controller.saveData,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
