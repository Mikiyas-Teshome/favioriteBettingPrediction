import 'package:faviorite_app/constants/color_constants.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor, // Your base color
    brightness: Brightness.light, // Light or dark theme
  ),
  scaffoldBackgroundColor: Colors.white,
  // Add more properties as needed for the light theme
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor, // Your base color
    brightness: Brightness.dark, // Light or dark theme
  ),
  scaffoldBackgroundColor: Color(0xff181818),

  // Add more properties as needed for the dark theme
);
