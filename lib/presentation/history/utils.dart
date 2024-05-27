import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:project/domain/entities/baby_height.dart';

({
  // Point<double> axisX,
  // Point<double> axisY,
  // Point<double> interval,
  List<FlSpot> spots,
}) transformData(List<BabyHeight> data) {
  if (data.isEmpty) {
    return (
      // axisX: const Point(0, 11),
      // axisY: const Point(0, 6),
      // interval: const Point(1, 1),
      spots: [],
    );
  }
  final heights = data.map((e) => e.height.toPrecision(2)).toList();
  // final minv = heights.reduce(min);
  // final maxv = heights.reduce(max);
  // final diff = maxv == minv ? 10 : maxv - minv;

  // final minY = max(minv - diff / 4, 0.0);
  // final maxY = maxv + diff / 4;
  // final delta = (maxY - minY) / 6;

  // const minX = 0.0;
  // final maxX = 11 * delta;
  // if (heights.length == 1) heights.add(heights.last);
  // final deltaX = maxX / (heights.length - 1);
  // final spots = heights.indexed
  //     .map(
  //       (e) => FlSpot(e.$1 * deltaX, e.$2),
  //     )
  //     .toList();
  final spots =
      heights.indexed.map((e) => FlSpot(e.$1.toDouble(), e.$2)).toList();
  return (
    // axisX: Point(minX, maxX),
    // axisY: Point(minY, maxY),
    // interval: Point(deltaX, delta),
    spots: spots,
  );
}
