import 'package:flutter/material.dart';

class WeatherImage extends StatelessWidget {
  final icon;
  const WeatherImage({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 100,
        child: Image.network(
          "http://openweathermap.org/img/wn/" + icon + "@2x.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
