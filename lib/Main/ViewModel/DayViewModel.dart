import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weatherfit/Main/Model/DayWeatherModel.dart';
import 'package:intl/intl.dart';

class DayViewModel with ChangeNotifier {
  DayViewModel() {
    getCurrentTime();
  }

  DayWeatherModel? _weather;
  DayWeatherModel? get weather => _weather;

  String currentTime = "";

  Future<void> fetchDayWeather() async {
    final lat = 36;
    final lon = 128;

    final API = dotenv.env['API_KEY'];

    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API&lang=kr'));

    if (response.statusCode == 200) {
      _weather = _weather = DayWeatherModel.fromJson(json.decode(response.body));
      convertTemp();
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    currentTime = DateFormat('EEEE, dd').format(now);
  }

  void convertTemp() {
    _weather?.main?.temp = roundToOneDecimal(kelvinToCelsius(_weather!.main!.temp!));
    _weather?.main?.tempMax = roundToOneDecimal(kelvinToCelsius(_weather!.main!.tempMax!));
    _weather?.main?.tempMin = roundToOneDecimal(kelvinToCelsius(_weather!.main!.tempMin!));
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double roundToOneDecimal(double value) {
    return (value * 10).roundToDouble() / 10;
  }
}
