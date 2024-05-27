import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project/core/theme/app_theme.dart';

import 'style.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) => SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '',
        style: AppTheme.family.copyWith(
          color: AppTheme.grey,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );

Widget leftTitleWidgets(double value, TitleMeta meta) => SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: AppTheme.family.copyWith(
          color: AppTheme.grey,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );

FlGridData get gridData => FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 10,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: mainGridLineColor,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: mainGridLineColor,
          strokeWidth: 1,
        );
      },
    );

LineChartData mainData(
  // Point<double> axisX,
  // Point<double> axisY,
  // Point<double> interval,
  List<FlSpot> spots,
) =>
    LineChartData(
      gridData: gridData,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 21,
          axisNameWidget: Text(
            'Tinggi (cm)',
            style: AppTheme.family.copyWith(
              color: AppTheme.dark,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          sideTitles: const SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 20,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      // minX: axisX.x,
      // maxX: axisX.y,
      // minY: axisY.x,
      // maxY: axisY.y,
      minX: 0,
      maxX: spots.length - 1,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          // gradient: LinearGradient(colors: gradientColors),
          color: AppTheme.primary800,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: AppTheme.primary400.withOpacity(0.5),
            // gradient: LinearGradient(
            //   colors: gradientColors
            //       .map((color) => color.withOpacity(0.3))
            //       .toList(),
            // ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppTheme.dark,
          getTooltipItems: (touchedSpots) =>
              touchedSpots.map((LineBarSpot touchedSpot) {
            final textStyle = AppTheme.family.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            return LineTooltipItem('${touchedSpot.y} cm', textStyle);
          }).toList(),
        ),
      ),
    );
