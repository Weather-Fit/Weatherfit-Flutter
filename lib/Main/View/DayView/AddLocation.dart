import 'package:flutter/material.dart';
import 'package:weatherfit/Main/ViewModel/MainViewModel.dart';

class AddLocation extends StatelessWidget {
  final MainViewModel viewModel;
  AddLocation({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: IconButton(
          onPressed: () {
            viewModel.fetchDayWeather();
          },
          icon: Icon(Icons.refresh),
          color: Colors.white,
        ),
      ),
    );
  }
}
