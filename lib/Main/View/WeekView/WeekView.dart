import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/WeekView/WeekItem.dart';
import 'package:weatherfit/app_theme.dart';

class WeekView extends StatelessWidget {
  const WeekView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme().lightTheme.colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            WeekItem(
                day: "월",
                weatherIcon: Icon(
                  Icons.sunny,
                  color: Colors.amber,
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
            WeekItem(
                day: "화",
                weatherIcon: Icon(
                  Icons.sunny,
                  color: Colors.amber,
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
            WeekItem(
                day: "수",
                weatherIcon: Icon(
                  Icons.sunny,
                  color: Colors.amber,
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
            WeekItem(
                day: "목",
                weatherIcon: Icon(
                  Icons.sunny,
                  color: Colors.amber,
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
            WeekItem(
                day: "금",
                weatherIcon: Icon(
                  Icons.sunny,
                  color: Colors.amber,
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
            WeekItem(
                day: "토",
                weatherIcon: Icon(
                  Icons.cloud,
                  color: Color.fromARGB(255, 222, 222, 222),
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
            WeekItem(
                day: "일",
                weatherIcon: Icon(
                  Icons.cloud,
                  color: Color.fromARGB(255, 222, 222, 222),
                  size: 35,
                ),
                maxMintemp: "최고 -4℃ / 최저 -9℃"),
          ],
        ),
      ),
    );
  }
}
