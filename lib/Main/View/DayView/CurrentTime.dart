import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentTime extends StatelessWidget {
  const CurrentTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        "오후 4:30",
        style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
