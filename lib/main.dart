import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/SplashScreen/splash_screen.dart';
import 'SharedPrefrences/sharedprefrences.dart';

late SharedPreferences _sharedPreferences;

bool? isFirstTime = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  await _initializePrefs();
  runApp(MyApp());
}

Future<void> _initializePrefs() async {
  _sharedPreferences = await SharedPreferences.getInstance();
  isFirstTime = SharedPreferencesHelper.getFirstTime();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the custom primary swatch color
    MaterialColor customPrimarySwatch = const MaterialColor(
      0xFFdb202c,
      <int, Color>{
        50: const Color(0xFFdb202c),
        100: const Color(0xFFdb202c),
        200: const Color(0xFFdb202c),
        300: const Color(0xFFdb202c),
        400: const Color(0xFFdb202c),
        500: const Color(0xFFdb202c),
        600: const Color(0xFFdb202c),
        700: const Color(0xFFdb202c),
        800: const Color(0xFFdb202c),
        900: const Color(0xFFdb202c),
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickCart',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch,
      ),
      home: SplashScreen(),
    );
  }
}
