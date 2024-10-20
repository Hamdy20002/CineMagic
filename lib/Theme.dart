import 'package:flutter/material.dart';

var KLightScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFF024CAA),
);
ThemeData LightTheme = ThemeData().copyWith(
  colorScheme: KLightScheme,
);

var KDarkScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFF605678),
  brightness: Brightness.dark,
);
ThemeData DarkTheme = ThemeData.dark().copyWith(
  colorScheme: KDarkScheme,
);
