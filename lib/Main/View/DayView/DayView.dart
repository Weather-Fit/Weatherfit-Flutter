import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/DayView/AddLocation.dart';
import 'package:weatherfit/Main/View/DayView/CurrentPlace.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTemp.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTime.dart';
import 'package:weatherfit/Main/View/DayView/CurrentWeather.dart';
import 'package:weatherfit/Main/View/DayView/MaxMinTemp.dart';
import 'package:weatherfit/Main/View/DayView/WeatherImage.dart';

class DayView extends StatelessWidget {
  DayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddLocation(),
          CurrentTime(),
          CurrentPlace(),
          CurrentWeather(),
          WeatherImage(),
          CurrentTemp(),
          MaxMinTemp(),
        ],
      ),
    );
  }
}
