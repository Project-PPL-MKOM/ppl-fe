import 'package:flutter/material.dart';
import 'package:project/core/theme/app_theme.dart';

class MessageView extends StatelessWidget {
  final String msg;
  final bool isError;

  const MessageView({super.key, this.msg = '', this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isError ? Icons.error : Icons.not_interested,
          color: isError ? Colors.red : AppTheme.grey,
        ),
        Text(
          msg,
          style: AppTheme.family.copyWith(color: AppTheme.dark),
        ),
      ],
    );
  }
}
