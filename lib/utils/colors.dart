import 'package:flutter/material.dart';

const MaterialColor mainColor = MaterialColor(_mainColorPrimaryValue, <int, Color>{
  50: Color(0xFFF9F5F3),
  100: Color(0xFFF2EAE6),
  200: Color(0xFFDECBC0),
  300: Color(0xFFC9A997),
  400: Color(0xFFA36C4D),
  500: Color(_mainColorPrimaryValue),
  600: Color(0xFF6E2900),
  700: Color(0xFF4A1B00),
  800: Color(0xFF381500),
  900: Color(0xFF240E00),
});

const int _mainColorPrimaryValue = 0xFF7B2D00;

const MaterialColor mainColorAccent = MaterialColor(_mainColorAccentValue, <int, Color>{
  100: Color(0xFFFF8E7F),
  200: Color(_mainColorAccentValue),
  400: Color(0xFFFF3419),
  700: Color(0xFFFE1E00),
});

const int _mainColorAccentValue = 0xFFFF614C;