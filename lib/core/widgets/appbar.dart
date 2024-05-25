import 'package:flutter/material.dart';
import 'package:project/core/theme/app_theme.dart';

final _appBarTitleStyle = AppTheme.family.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

PreferredSizeWidget appBar({
  required String title,
  bool withBack = false,
  void Function()? onBack,
}) =>
    AppBar(
      title: Text(title, style: _appBarTitleStyle),
      centerTitle: true,
      leading: withBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18.0),
              tooltip: 'Kembali',
              onPressed: onBack,
            )
          : null,
    );
