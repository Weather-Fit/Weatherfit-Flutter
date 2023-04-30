import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class MinTemp extends StatelessWidget {
  final minTemp;

  const MinTemp({required this.minTemp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "최저 온도",
            style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
          ),
          Text(
            "$minTempº",
            style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(220, 255, 255, 255),
                ),
          ),
        ],
      ),
    );
  }
}
