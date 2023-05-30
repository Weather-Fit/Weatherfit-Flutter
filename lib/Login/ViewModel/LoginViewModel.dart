import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';

  bool get isLoginDataValid => email.isNotEmpty && password.isNotEmpty;

  void setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void setPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  Future<bool> login() async {
    return email == 'test' && password == '123';
  }
}
