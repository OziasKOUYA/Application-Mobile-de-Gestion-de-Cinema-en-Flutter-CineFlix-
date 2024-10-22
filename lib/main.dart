
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(App(savedThemeMode: savedThemeMode ?? AdaptiveThemeMode.system, sharedPreferences: sharedPreferences,));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}