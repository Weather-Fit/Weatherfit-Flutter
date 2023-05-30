import 'package:flutter/material.dart';
import 'package:weatherfit/Main/ViewModel/MainViewModel.dart';
import 'package:weatherfit/app_theme.dart';

class CurrentPlace extends StatelessWidget {
  final location;
  final MainViewModel viewModel;
  const CurrentPlace({required this.location, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        viewModel.searchCity(context);
      },
      child: Text(
        location,
        style: AppTheme().lightTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(190, 255, 255, 255),
            ),
      ),
    );
  }
}
