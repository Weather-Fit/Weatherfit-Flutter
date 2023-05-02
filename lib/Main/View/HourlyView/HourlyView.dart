import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/HourlyView/HourlyItem.dart';
import 'package:weatherfit/Main/ViewModel/MainViewModel.dart';

class HourlyView extends StatelessWidget {
  final MainViewModel viewModel;
  HourlyView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            viewModel.times.length,
            (index) => HourlyItem(
              time: viewModel.times[index],
              weatherIcon: Image.network(
                "http://openweathermap.org/img/wn/" + viewModel.afterHour[index].weather!.first.icon! + "@2x.png",
                fit: BoxFit.cover,
                width: 55,
                height: 40,
              ),
              temp: "${viewModel.afterHour[index].main!.temp!}º",
            ),
          ),
        ),
      ),
    );
  }
}
