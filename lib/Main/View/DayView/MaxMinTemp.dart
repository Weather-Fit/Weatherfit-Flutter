import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class MaxMinTemp extends StatelessWidget {
  final maxTemp;
  final minTemp;

  const MaxMinTemp({required this.maxTemp, required this.minTemp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        "최고 $maxTemp℃ / 최저 $minTemp℃",
        style: AppTheme().lightTheme.textTheme.bodyMedium,
      ),
    );
  }
}
