import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentWeather extends StatelessWidget {
  final weather;

  const CurrentWeather({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Text(
      weather,
      style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
            color: Color.fromARGB(180, 255, 255, 255),
          ),
    );
  }
}
