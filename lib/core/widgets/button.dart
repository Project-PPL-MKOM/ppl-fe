import 'package:flutter/material.dart';
import 'package:project/core/theme/app_theme.dart';

Widget actionButton({
  required String label,
  required Color color,
  void Function()? onPressed,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // button's shape
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: AppTheme.family.copyWith(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
