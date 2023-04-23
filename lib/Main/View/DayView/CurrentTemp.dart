import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentTemp extends StatelessWidget {
  final temp;
  const CurrentTemp({required this.temp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        temp.toString(),
        style: AppTheme().lightTheme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
      ),
    );
  }
}
