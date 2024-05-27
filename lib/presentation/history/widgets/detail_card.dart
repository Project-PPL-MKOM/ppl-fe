import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/utils/ext.dart';
import 'package:project/domain/entities/baby_height.dart';

class HeightDetailCard extends StatelessWidget {
  final BabyHeight data;
  final BabyHeight? _prevData;

  const HeightDetailCard({
    super.key,
    required this.data,
    BabyHeight? prevData,
  }) : _prevData = prevData;

  int get _dateDiff => _prevData != null
      ? data.timestamp.difference(_prevData.timestamp).inDays
      : 0;

  double get _heightDiff =>
      _prevData != null ? data.height - _prevData.height : 0;

  Color get _heightDiffColor => switch (_heightDiff) {
        < 0 => Colors.red,
        > 0 => Colors.green,
        _ => Colors.grey,
      };

  String get _heightDiffSign => switch (_heightDiff) {
        < 0 => '-',
        > 0 => '+',
        _ => '',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        // color: AppTheme.primary400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                data.timestamp.repr,
                style: AppTheme.family.copyWith(
                  fontSize: 16,
                  color: AppTheme.dark,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                '${data.height.toPrecision(2)} cm',
                style: AppTheme.family.copyWith(
                  fontSize: 16,
                  color: AppTheme.dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          _prevData != null
              ? Row(
                  children: [
                    Text(
                      _dateDiff <= 0 ? '< 0 hari' : '~$_dateDiff hari',
                      style: AppTheme.family.copyWith(
                        fontSize: 16,
                        color: AppTheme.green,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      '$_heightDiffSign${_heightDiff.toPrecision(2).abs()} cm',
                      style: AppTheme.family.copyWith(
                        fontSize: 16,
                        color: _heightDiffColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
