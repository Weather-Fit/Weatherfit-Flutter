import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class WeekItem extends StatelessWidget {
  final String day;
  final Icon weatherIcon;
  final String maxMintemp;

  WeekItem({required this.day, required this.weatherIcon, required this.maxMintemp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            weatherIcon,
            Text(maxMintemp),
          ],
        ),
      ),
    );
  }
}
