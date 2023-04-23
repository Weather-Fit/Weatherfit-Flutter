import 'package:flutter/material.dart';
import 'package:weatherfit/Login/View/LoginView.dart';
import 'package:weatherfit/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
