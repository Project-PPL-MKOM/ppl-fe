import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/widgets/appbar.dart';
import 'package:project/presentation/history/utils.dart';
import 'package:project/presentation/history/widgets.dart';
import 'controller.dart';
import 'widgets/detail_card.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'Riwayat',
        withBack: true,
        onBack: () => Get.back(),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: Obx(
                () {
                  // ignore: invalid_use_of_protected_member
                  final data = controller.heights.value;
                  // final (:axisX, :axisY, :spots, :interval) = transformData(data);
                  final (:spots) = transformData(data);
                  return LineChart(
                    // mainData(axisX, axisY, interval, spots),
                    mainData(spots),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Obx(
                () => ListView.builder(
                  // ignore: invalid_use_of_protected_member
                  itemCount: controller.heights.value.length,
                  itemBuilder: (_, i) => HeightDetailCard(
                    data: controller.heights[i],
                    prevData: i > 0 ? controller.heights[i - 1] : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
