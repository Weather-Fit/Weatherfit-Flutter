import 'package:flutter/material.dart';
import 'package:weatherfit/Main/View/WeekView/WeekItem.dart';
import 'package:weatherfit/Main/ViewModel/MainViewModel.dart';

class WeekView extends StatelessWidget {
  final MainViewModel viewModel;
  const WeekView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 16),
      child: Container(
        width: screenSize.width - 30,
        decoration: BoxDecoration(
          color: Color.fromARGB(50, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: List.generate(
            viewModel.afterDay.length,
            (index) => WeekItem(
              day: viewModel.days[index],
              weatherIcon: Image.network(
                "http://openweathermap.org/img/wn/" +
                    viewModel.afterHour[index].weather!.first.icon! +
                    "@2x.png",
                fit: BoxFit.cover,
                width: 45,
                height: 40,
              ),
              maxTemp: "${viewModel.minMaxTemp[index][1]}º",
              minTemp: "${viewModel.minMaxTemp[index][0]}º",
            ),
          ),
        ),
      ),
    );
  }
}
