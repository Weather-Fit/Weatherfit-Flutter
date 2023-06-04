import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherfit/Login/View/LoginView.dart';
import 'package:provider/provider.dart';

import 'package:weatherfit/Main/View/MainView.dart';

import 'Calendar/View/CalendarView.dart';
import 'Util/calendar_service.dart';

import 'Util/auth_service.dart';
import 'Util/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Util/OnboardingPage.dart';
import 'Util/calendar_service.dart';
import 'Login/View/LoginView.dart';
import 'Util/auth_service.dart';
import 'Util/firebase_options.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // firebase 앱 시작
  await dotenv.load(fileName: '.env');
  await Permission.location.request();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthService>().currentUser();
  }

  @override
  Widget build(BuildContext context) {
    print("main: ${RecordService.instance.user}\n");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          RecordService.instance.user == null ? LoginView() : OnboardingPage(),
    );
  }
}
