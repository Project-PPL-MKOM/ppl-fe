import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/domain/entities/baby_profile.dart';

class DisplayProfile extends StatelessWidget {
  final BabyProfile? data;

  const DisplayProfile({super.key, this.data});

  Color get _bgColor =>
      data?.gender == Gender.male ? AppTheme.primary100 : AppTheme.pink100;
  IconData get _icon =>
      data?.gender == Gender.male ? Icons.face_6 : Icons.face_3;
  Color get _iconColor =>
      data?.gender == Gender.male ? AppTheme.primary400 : AppTheme.pink400;

  int get _age =>
      data == null ? 0 : DateTime.now().difference(data!.bornDate).inDays ~/ 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_icon, color: _iconColor),
              const SizedBox(width: 14),
              Text(
                data?.name ?? '-',
                style: AppTheme.family.copyWith(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              // const Spacer(),
              // Text('$_age bulan',
              //     style: AppTheme.family.copyWith(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.date_range_rounded, color: _iconColor),
              const SizedBox(width: 14),
              FutureBuilder(
                  future: initializeDateFormatting('id_ID', null),
                  builder: (_, __) {
                    final date = data == null
                        ? '-'
                        : DateFormat('dd MMM yyyy', 'id_ID')
                            .format(data!.bornDate);
                    return Text(
                      '$date ($_age bulan)',
                      style: AppTheme.family.copyWith(fontSize: 20),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
