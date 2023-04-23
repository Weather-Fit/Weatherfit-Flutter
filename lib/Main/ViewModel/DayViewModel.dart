import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weatherfit/Main/Model/DayWeatherModel.dart';

class DayViewModel with ChangeNotifier {
  DayWeatherModel? _weather;
  DayWeatherModel? get weather => _weather;

  Future<void> fetchDayWeather() async {
    final lat = 36;
    final lon = 128;
    final API = dotenv.env['API_KEY'];

    final response =
        await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API'));

    if (response.statusCode == 200) {
      _weather = _weather = DayWeatherModel.fromJson(json.decode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
