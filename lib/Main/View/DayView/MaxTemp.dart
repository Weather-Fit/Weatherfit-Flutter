import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class MaxTemp extends StatelessWidget {
  final maxTemp;

  const MaxTemp({required this.maxTemp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "최고 온도",
            style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
          ),
          Text(
            "$maxTempº",
            style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
          ),
        ],
      ),
    );
  }
}
