import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherfit/Main/Model/DayWeatherModel.dart';
import 'package:intl/intl.dart';
import 'package:weatherfit/Main/Model/WeekWeatherModel.dart';

class MainViewModel with ChangeNotifier {
  MainViewModel() {
    getCurrentTime();
  }

  DayWeatherModel? _weather;
  DayWeatherModel? get weather => _weather;

  WeekWeatherModel? _weatherList;
  WeekWeatherModel? get weatherList => _weatherList;

  List<Lists> afterHour = [];
  List<Lists> afterDay = [];
  List<List<double>> minMaxTemp = [];

  List<String> times = [];
  List<String> days = [];
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
      _weather = DayWeatherModel.fromJson(json.decode(response.body));
      convertDayWeatherTemp();
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> fetchWeekWeather() async {
    await requestLocationPermission();

    final lat = position?.latitude;
    final lon = position?.longitude;
    final API = dotenv.env['API_KEY'];

    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$API&lang=kr'));

    if (response.statusCode == 200) {
      _weatherList = WeekWeatherModel.fromJson(json.decode(response.body));
      formatUnixTimestamp();
      convertHourWeatherTemp();
      afterDaySetting();
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
        await getCurrentPosition();
      } else {
        print("위치 권한이 거부되었습니다.");
      }
    } else if (status.isGranted) {
      await getCurrentPosition();
    }
  }

  Future<void> getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      // 좌표를 주소로 변환
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
        localeIdentifier: 'ko_KR', // 한글 주소를 얻기 위해 로캘 설정
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        location = "${placemark.locality} ${placemark.subLocality}";
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

  void convertDayWeatherTemp() {
    _weather?.main?.temp = roundToOneDecimal(kelvinToCelsius(_weather!.main!.temp!));
    _weather?.main?.tempMax = roundToOneDecimal(kelvinToCelsius(_weather!.main!.tempMax!));
    _weather?.main?.tempMin = roundToOneDecimal(kelvinToCelsius(_weather!.main!.tempMin!));
  }

  void convertHourWeatherTemp() {
    _weatherList!.list!.forEach((element) {
      element.main?.temp = roundToOneDecimal(kelvinToCelsius(element.main!.temp!));
      element.main?.tempMax = roundToOneDecimal(kelvinToCelsius(element.main!.tempMax!));
      element.main?.tempMin = roundToOneDecimal(kelvinToCelsius(element.main!.tempMin!));
    });
  }

  void formatUnixTimestamp() {
    int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    DateFormat dateFormat = DateFormat('HH:mm');
    afterHour = _weatherList!.list!.where((element) => element.dt! > currentTime).toList();
    for (int i = 0; i < 5; i++) {
      times.add(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(afterHour[i].dt! * 1000)));
    }
  }

  void afterDaySetting() {
    const int chunkSize = 8;
    List<List<Lists>> chunks = [];

    // 리스트를 8개씩 끊어서 묶음 만들기
    for (int i = 0; i < _weatherList!.list!.length; i += chunkSize) {
      chunks.add(_weatherList!.list!.sublist(i, i + chunkSize));
    }

    // 각 묶음에서 최소값과 최대값 구하기
    for (int i = 0; i < chunks.length; i++) {
      Lists min = chunks[i].reduce((a, b) => a.main!.temp! < b.main!.temp! ? a : b);
      Lists max = chunks[i].reduce((a, b) => a.main!.temp! > b.main!.temp! ? a : b);
      print('Group ${i + 1}: Min = ${min.main!.temp!}, Max = ${max.main!.temp!}');

      minMaxTemp.add([min.main!.temp!, max.main!.temp!]);
    }

    afterDay = [
      _weatherList!.list![4],
      _weatherList!.list![12],
      _weatherList!.list![20],
      _weatherList!.list![28],
      _weatherList!.list![36],
    ];
    DateFormat dateFormat = DateFormat('EEEE, dd');
    for (int i = 0; i < afterDay.length; i++) {
      days.add(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(afterDay[i].dt! * 1000)));
    }
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double roundToOneDecimal(double value) {
    return (value * 10).roundToDouble() / 10;
  }
}
