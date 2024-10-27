import 'package:flutter/material.dart';

var KLightScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFF00ADB5),
);
ThemeData LightTheme = ThemeData().copyWith(
  colorScheme: KLightScheme,
);

var KDarkScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFF8785A2),
  brightness: Brightness.dark,
);
ThemeData DarkTheme = ThemeData.dark().copyWith(
  colorScheme: KDarkScheme,
);
