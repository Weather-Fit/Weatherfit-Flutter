import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentTemp extends StatelessWidget {
  const CurrentTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        "-5℃",
        style: AppTheme().lightTheme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
      ),
    );
  }
}
