import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class Wind extends StatelessWidget {
  final windSpeed;

  const Wind({required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "바람",
            style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
          ),
          Text(
            "${windSpeed}m/s",
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
