import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherfit/Main/Model/DayWeatherModel.dart';
import 'package:intl/intl.dart';

class DayViewModel with ChangeNotifier {
  DayViewModel() {
    getCurrentTime();
  }

  DayWeatherModel? _weather;
  DayWeatherModel? get weather => _weather;

  String currentTime = "";
  String location = "";
  Position? position;

  Future<void> fetchDayWeather() async {
    await requestLocationPermission();

    final lat = position?.latitude;
    final lon = position?.longitude;
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

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      PermissionStatus result = await Permission.location.request();
      if (result.isGranted) {
        // 위치 권한이 승인되었습니다. 필요한 작업을 수행하세요.
        await getCurrentPosition();
      } else {
        // 위치 권한이 거부되었습니다. 다른 작업을 수행하거나 사용자에게 알림을 표시하세요.
        print("위치 권한이 거부되었습니다.");
      }
    } else if (status.isGranted) {
      // 위치 권한이 이미 승인되었습니다. 필요한 작업을 수행하세요.
      await getCurrentPosition();
    }
  }

  Future<void> getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      print(position);
      // 좌표를 주소로 변환
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
        localeIdentifier: 'ko_KR', // 한글 주소를 얻기 위해 로캘 설정
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        location = "${placemark.locality} ${placemark.subLocality}";
        print("${placemark.locality} ${placemark.subLocality}");
      } else {
        print("주소를 찾을 수 없습니다.");
      }
    } catch (e) {
      print(e);
      print("주소를 찾을 수 없습니다.");
    }
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    currentTime = DateFormat('EEEE, dd').format(now) + "일";
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
