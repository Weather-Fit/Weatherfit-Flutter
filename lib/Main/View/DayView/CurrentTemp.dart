import 'package:flutter/material.dart';
import 'package:weatherfit/Util/Widget/RecommendPopupView.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentTemp extends StatelessWidget {
  final double temp;
  const CurrentTemp({required this.temp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: RecommendPopupView(
        temp: "${temp.toString()}º",
        child: Text(
          "${temp.toString()}º",
          style: AppTheme().lightTheme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(190, 255, 255, 255),
                fontSize: 48,
              ),
        ),
      ),
    );
  }
}
