import 'package:flutter/material.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/domain/entities/baby_profile.dart';

Widget get space => const SizedBox(height: 20);

Widget labelText(String label) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: AppTheme.family.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

Widget genderButton({
  required Gender gender,
  bool selected = false,
  void Function()? onSelected,
}) =>
    Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            selected ? AppTheme.dark : const Color(0xFFEEEEEE),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        onPressed: onSelected,
        child: Text(
          gender == Gender.male ? 'Laki-laki' : 'Perempuan',
          style: AppTheme.family.copyWith(
            fontSize: 16,
            color: selected ? Colors.white : AppTheme.dark,
          ),
        ),
      ),
    );
