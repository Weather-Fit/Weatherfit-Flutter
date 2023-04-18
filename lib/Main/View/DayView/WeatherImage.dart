import 'package:flutter/material.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Icon(
        Icons.sunny,
        size: 90,
        color: Colors.yellow,
      ),
    );
  }
}
