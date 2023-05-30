import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentTime extends StatelessWidget {
  final time;
  const CurrentTime({required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        time,
        style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              color: Color.fromARGB(170, 255, 255, 255),
            ),
      ),
    );
  }
}
