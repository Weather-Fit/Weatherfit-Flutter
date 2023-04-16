import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        "최고 -4℃ / 최저 -9℃",
        style: AppTheme().lightTheme.textTheme.bodyMedium,
      ),
    );
  }
}
