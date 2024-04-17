import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(156, 64, 155, 252));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125));

void main() {
  runApp( 
    MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme: const CardTheme().copyWith(
      color: kDarkColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 10, 
      vertical: 5),
      ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 10, 
      vertical: 5),
      ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 4, 37, 67),
      )
    ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
  ),
  );
}

