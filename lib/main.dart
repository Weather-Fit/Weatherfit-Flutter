import 'package:flutter/material.dart';
import 'package:weatherfit/Login/View/LoginView.dart';
import 'package:weatherfit/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Login Example',
      theme: AppTheme().lightTheme,
      home: SafeArea(
        child: LoginView(),
      ),
    );
  }
}
