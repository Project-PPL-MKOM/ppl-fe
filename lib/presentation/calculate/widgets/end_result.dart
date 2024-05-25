import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
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
            // TODO: show real image
            child: Image.asset(
              controller.annotationPath,
              width: _width,
              height: _height,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tinggi badan : ${controller.heightResult} cm',
          textAlign: TextAlign.center,
          style: AppTheme.family
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            actionButton(
              label: 'Ulangi',
              color: AppTheme.red,
              onPressed: controller.backToStart,
            ),
            const SizedBox(width: 16),
            actionButton(
              label: 'Selesai',
              color: AppTheme.primary800,
              onPressed: controller.saveData,
            ),
          ],
        ),
      ],
    );
  }
}
