import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/DayView/AddLocation.dart';
import 'package:weatherfit/Main/View/DayView/CurrentPlace.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTemp.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTime.dart';
import 'package:weatherfit/Main/View/DayView/Humidity.dart';
import 'package:weatherfit/Main/View/DayView/MaxTemp.dart';
import 'package:weatherfit/Main/View/DayView/MinTemp.dart';
import 'package:weatherfit/Main/View/DayView/WeatherImage.dart';
import 'package:weatherfit/Main/View/DayView/Wind.dart';
import 'package:weatherfit/Main/ViewModel/MainViewModel.dart';

class DayView extends StatelessWidget {
  final MainViewModel viewModel;
  DayView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddLocation(viewModel: viewModel),
          CurrentTime(time: viewModel.currentTime),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CurrentPlace(
                      location: viewModel.location, viewModel: viewModel),
                  CurrentTemp(temp: viewModel.weather!.main!.temp!),
                ],
              ),
              Column(
                children: [
                  // CurrentWeather(weather: viewModel.weather!.weather?.first.description),
                  WeatherImage(icon: viewModel.weather!.weather?.first.icon),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaxTemp(
                maxTemp: viewModel.weather!.main?.tempMax,
              ),
              MinTemp(
                minTemp: viewModel.weather!.main?.tempMin,
              ),
              Wind(
                windSpeed: viewModel.weather!.wind?.speed,
              ),
              Humidity(
                humidity: viewModel.weather!.main?.humidity,
              )
            ],
          ),
        ],
      ),
    );
  }
}
