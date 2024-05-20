import 'package:flutter/material.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/domain/entities/baby_profile.dart';

class BabyCard extends StatelessWidget {
  final BabyProfile data;

  const BabyCard({
    super.key,
    required this.data,
  });

  Color get _bgColor =>
      data.gender == Gender.male ? AppTheme.primary100 : AppTheme.pink100;
  IconData get _icon =>
      data.gender == Gender.male ? Icons.face_6 : Icons.face_3;
  Color get _iconColor =>
      data.gender == Gender.male ? AppTheme.primary400 : AppTheme.pink400;

  int get _age => DateTime.now().difference(data.bornDate).inDays ~/ 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(_icon, color: _iconColor),
          const SizedBox(width: 14),
          Text(
            data.name,
            style: AppTheme.family.copyWith(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text('$_age bulan', style: AppTheme.family.copyWith(fontSize: 16)),
          const SizedBox(width: 10),
          Icon(Icons.chevron_right_rounded, color: _iconColor),
        ],
      ),
    );
  }
}
