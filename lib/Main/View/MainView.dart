import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Main/View/DayView/DayView.dart';
import 'package:weatherfit/Main/View/WeekView/WeekView.dart';
import 'package:weatherfit/Main/View/HourlyView/HourlyView.dart';
import 'package:weatherfit/Main/ViewModel/MainViewModel.dart';
import 'package:weatherfit/Util/Loading.dart';
import 'package:weatherfit/app_theme.dart';

class MainView extends StatefulWidget {
  MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainViewModel viewModel = MainViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchDayWeather();
    viewModel.fetchWeekWeather();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainViewModel>(
      create: (context) => viewModel,
      child: Consumer<MainViewModel>(
        builder: (context, value, child) {
          if (value.weather == null) {
            return Loading();
          }
          return Scaffold(
            backgroundColor: AppTheme().lightTheme.colorScheme.secondary,
            body: SafeArea(
              child: Container(
                color: AppTheme().lightTheme.colorScheme.secondary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DayView(viewModel: viewModel),
                    HourlyView(viewModel: viewModel),
                    WeekView(viewModel: viewModel),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
