import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/DayView/AddLocation.dart';
import 'package:weatherfit/Main/View/DayView/CurrentPlace.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTemp.dart';
import 'package:weatherfit/Main/View/DayView/CurrentTime.dart';
import 'package:weatherfit/Main/View/DayView/Humidity.dart';
import 'package:weatherfit/Main/View/DayView/MaxTemp.dart';
import 'package:weatherfit/Main/View/DayView/MinTemp.dart';
import 'package:weatherfit/Main/View/DayView/WeatherImage.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Main/View/DayView/Wind.dart';
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
    super.initState();
    viewModel.fetchDayWeather();
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
                  CurrentTime(time: viewModel.currentTime),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CurrentPlace(location: viewModel.location),
                          CurrentTemp(temp: viewModel.weather!.main?.temp),
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
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
