import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/widgets/button.dart';
import '../controller.dart';

const _width = 210.0;
const _height = _width * 4 / 3;

class TakePhoto extends StatelessWidget {
  const TakePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculateController>();

    return Column(
      children: [
        Obx(
          () {
            final done = controller.imagePath.value != null;
            return Text(
              done
                  ? 'Lanjutkan ke tahap pemrosesan gambar. Ulangi pengambilan gambar jika diperlukan'
                  : 'Ambil gambar bayi yang ingin diukur tingginya',
              textAlign: TextAlign.center,
              style: AppTheme.family
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            );
          },
        ),
        const SizedBox(height: 16),
        DottedBorder(
          color: Colors.black,
          strokeWidth: 1,
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: _width,
            height: _height,
            child: Obx(
              () {
                final path = controller.imagePath.value;
                final ready = controller.isCameraIdle.value;
                if (!ready) {
                  return const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                return path != null
                    ? Image.file(File(path), width: _width, height: _height)
                    : Container(
                        width: _width,
                        height: _height,
                        alignment: Alignment.center,
                        color: AppTheme.grey,
                      );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () {
            final done = controller.imagePath.value != null;
            final ready = controller.isCameraIdle.isTrue;
            return Row(
              children: [
                Expanded(
                  child: actionButton(
                    label: done ? 'Ulangi' : 'Ambil gambar',
                    color: ready
                        ? done
                            ? AppTheme.red
                            : AppTheme.primary800
                        : AppTheme.grey,
                    onPressed: () {
                      if (ready) controller.tookPhoto();
                    },
                  ),
                ),
                done ? const SizedBox(width: 16) : const SizedBox(),
                done
                    ? Expanded(
                        child: actionButton(
                          label: 'Lanjut',
                          color: ready ? AppTheme.primary800 : AppTheme.grey,
                          onPressed: () {
                            if (ready) controller.beginProcessing();
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }
}
