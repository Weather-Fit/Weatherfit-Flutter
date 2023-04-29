import 'package:flutter/material.dart';

class WeatherImage extends StatelessWidget {
  final icon;
  const WeatherImage({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 70,
      child: Image.network(
        "http://openweathermap.org/img/wn/" + icon + "@2x.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
