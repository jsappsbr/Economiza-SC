import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: Colors.red,
  appBarTheme: const AppBarTheme(color: Colors.red),
  iconTheme: const IconThemeData(color: Colors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white, 
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white
  ),
    buttonTheme: const ButtonThemeData(
    buttonColor: Colors.red, 
  ),
);
