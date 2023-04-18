import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    fontFamily: 'Pretendart',
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w800),
      displayMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
      bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(0, 191, 255, 1),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFC1E8FF),
      onPrimaryContainer: Color(0xFF001E2B),
      secondary: Color(0xFF005CBD),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD7E2FF),
      onSecondaryContainer: Color(0xFF001A40),
      tertiary: Color.fromARGB(255, 162, 215, 255),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFC3E8FF),
      onTertiaryContainer: Color(0xFF001E2C),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFDFBFF),
      onBackground: Color(0xFF001B3D),
      surface: Color(0xFFFDFBFF),
      onSurface: Color(0xFF001B3D),
      surfaceVariant: Color(0xFFDCE3E9),
      onSurfaceVariant: Color(0xFF40484D),
      outline: Color(0xFF71787D),
      onInverseSurface: Color(0xFFECF0FF),
      inverseSurface: Color(0xFF003062),
      inversePrimary: Color(0xFF74D1FF),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF006688),
      outlineVariant: Color(0xFFC0C7CD),
      scrim: Color(0xFF000000),
    ),
  );
}
