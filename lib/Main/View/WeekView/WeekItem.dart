import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class WeekItem extends StatelessWidget {
  final String day;
  final Image weatherIcon;
  final String maxTemp;
  final String minTemp;

  WeekItem({required this.day, required this.weatherIcon, required this.maxTemp, required this.minTemp});

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
              style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Color.fromARGB(180, 255, 255, 255),
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
            ),
            Container(
              width: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatherIcon,
                  Text(
                    maxTemp,
                    style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(220, 255, 255, 255),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    minTemp,
                    style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(180, 255, 255, 255),
                          fontWeight: FontWeight.w700,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
