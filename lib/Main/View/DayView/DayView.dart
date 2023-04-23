import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/DayView/AddLocation.dart';
import 'package:weatherfit/Main/View/DayView/CurrentPlace.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTemp.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTime.dart';
import 'package:weatherfit/Main/View/DayView/CurrentWeather.dart';
import 'package:weatherfit/Main/View/DayView/MaxMinTemp.dart';
import 'package:weatherfit/Main/View/DayView/WeatherImage.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Main/ViewModel/DayViewModel.dart';
import 'package:weatherfit/Util/Loading.dart';

class DayView extends StatefulWidget {
  DayView({super.key});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  final DayViewModel viewModel = DayViewModel();

  @override
  void initState() {
    viewModel.fetchDayWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DayViewModel>(
      create: (context) => viewModel,
      child: Consumer<DayViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.weather != null) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddLocation(),
                  CurrentTime(),
                  CurrentPlace(),
                  CurrentWeather(weather: viewModel.weather!.weather?.first.main),
                  WeatherImage(),
                  CurrentTemp(),
                  MaxMinTemp(),
                ],
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
