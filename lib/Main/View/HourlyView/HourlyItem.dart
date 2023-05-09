import 'package:flutter/material.dart';
import 'package:weatherfit/Util/Widget/RecommendPopupView.dart';
import 'package:weatherfit/app_theme.dart';

class HourlyItem extends StatelessWidget {
  final String time;
  final Image weatherIcon;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  time,
                  style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                        color: Color.fromARGB(180, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                child: RecommendPopupView(
                  temp: temp,
                  child: Text(
                    temp,
                    style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(220, 255, 255, 255),
                          fontWeight: FontWeight.w800,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              weatherIcon,
            ],
          ),
        ),
      ),
    );
  }
}
