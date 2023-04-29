import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentPlace extends StatelessWidget {
  final location;
  const CurrentPlace({required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        location,
        style: AppTheme().lightTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(190, 255, 255, 255),
            ),
      ),
    );
  }
}
