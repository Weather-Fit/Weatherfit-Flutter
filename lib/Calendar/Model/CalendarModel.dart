class CalendarModel {
  late String _text;
  late String _image;

  String get text => _text;
  String get image => _image;

  set text(String text) {
    _text = text;
  }

  set image(String image) {
    _image = image;
  }
}
