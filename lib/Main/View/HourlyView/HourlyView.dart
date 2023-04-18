import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/HourlyView/HourlyItem.dart';
import 'package:weatherfit/app_theme.dart';

class HourlyView extends StatelessWidget {
  const HourlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HourlyItem(
              time: "오후 1시",
              weatherIcon: Icon(
                Icons.cloud,
                color: Color.fromARGB(255, 222, 222, 222),
                size: 50,
              ),
              temp: "-5℃",
            ),
            HourlyItem(
              time: "오후 2시",
              weatherIcon: Icon(
                Icons.cloud,
                color: Color.fromARGB(255, 222, 222, 222),
                size: 50,
              ),
              temp: "-3℃",
            ),
            HourlyItem(
              time: "오후 3시",
              weatherIcon: Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 50,
              ),
              temp: "-2℃",
            ),
            HourlyItem(
              time: "오후 4시",
              weatherIcon: Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 50,
              ),
              temp: "-2℃",
            ),
            HourlyItem(
              time: "오후 5시",
              weatherIcon: Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 50,
              ),
              temp: "-3℃",
            ),
          ],
        ),
      ),
    );
  }
}
