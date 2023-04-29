import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/DayView/DayView.dart';
import 'package:weatherfit/Main/View/WeekView/WeekView.dart';
import 'package:weatherfit/Main/View/HourlyView/HourlyView.dart';
import 'package:weatherfit/app_theme.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().lightTheme.colorScheme.secondary,
      body: SafeArea(
        child: Container(
          color: AppTheme().lightTheme.colorScheme.secondary,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DayView(),
                  HourlyView(),
                  WeekView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
