// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDNO4U0DSRpgXsK1RG7o1_xyxirTjH6XqU',
    appId: '1:819583882098:web:3e2e0522bded261ff543eb',
    messagingSenderId: '819583882098',
    projectId: 'weatherfit-be9a8',
    authDomain: 'weatherfit-be9a8.firebaseapp.com',
    storageBucket: 'weatherfit-be9a8.appspot.com',
    measurementId: 'G-PT31E07QW9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQli52Jg1cLVkFVqLpgnn5IHvWnONZDsQ',
    appId: '1:819583882098:android:63d5890ae0589f01f543eb',
    messagingSenderId: '819583882098',
    projectId: 'weatherfit-be9a8',
    storageBucket: 'weatherfit-be9a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACzbfPgEHwUg_7V9jS_OoiDlppvkDHjus',
    appId: '1:819583882098:ios:34bd3ac420ae1990f543eb',
    messagingSenderId: '819583882098',
    projectId: 'weatherfit-be9a8',
    storageBucket: 'weatherfit-be9a8.appspot.com',
    iosClientId:
        '819583882098-s6r62dcekee4iemilk36l2bj83q1iseg.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherfit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACzbfPgEHwUg_7V9jS_OoiDlppvkDHjus',
    appId: '1:819583882098:ios:34bd3ac420ae1990f543eb',
    messagingSenderId: '819583882098',
    projectId: 'weatherfit-be9a8',
    storageBucket: 'weatherfit-be9a8.appspot.com',
    iosClientId:
        '819583882098-s6r62dcekee4iemilk36l2bj83q1iseg.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherfit',
  );
}
