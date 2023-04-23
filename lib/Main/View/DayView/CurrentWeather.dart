import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentWeather extends StatelessWidget {
  final weather;

  const CurrentWeather({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        weather,
        style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
              color: Color.fromARGB(255, 80, 80, 80),
            ),
      ),
    );
  }
}
