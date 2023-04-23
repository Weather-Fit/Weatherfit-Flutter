import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentTime extends StatelessWidget {
  final time;
  const CurrentTime({required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        time,
        style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
