import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        "맑음",
        style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
              color: Color.fromARGB(255, 80, 80, 80),
            ),
      ),
    );
  }
}
