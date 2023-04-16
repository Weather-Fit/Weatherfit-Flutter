import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentPlace extends StatelessWidget {
  const CurrentPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        "구로구 항동",
        style: AppTheme().lightTheme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}