import 'package:weatherfit/Login/Model/UserModel.dart';

class CalendarModel {
  late String _text;
  late String _image;

  //CalendarModel(text, img);

  String get text => _text;
  String get image => _image;

  set text(String text) {
    _text = text;
  }

  set image(String image) {
    _image = image;
  }

  //CalendarModel({required this.text, required this.image});
}
