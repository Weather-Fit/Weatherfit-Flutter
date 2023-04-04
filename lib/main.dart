import 'package:flutter/material.dart';
import 'package:weatherfit/Login/View/LoginView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Login Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginView(),
    );
  }
}
