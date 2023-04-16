import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class HourlyItem extends StatelessWidget {
  final String time;
  final Icon weatherIcon;
  final String temp;

  HourlyItem({
    required this.time,
    required this.weatherIcon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  time,
                  style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: weatherIcon,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  temp,
                  style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
