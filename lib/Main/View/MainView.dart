import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/DayView/DayView.dart';
import 'package:weatherfit/app_theme.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().lightTheme.colorScheme.tertiary,
      body: SafeArea(
        child: Container(
          color: AppTheme().lightTheme.colorScheme.tertiary,
          child: Center(
            child: Column(
              children: [
                DayView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
