import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppPalette.yellow,
        secondary: AppPalette.purple,
        background: AppPalette.white,
        surface: AppPalette.white,
        error: AppPalette.red,
        onPrimary: AppPalette.black,
        onSecondary: AppPalette.white,
        onBackground: AppPalette.black,
        onSurface: AppPalette.black,
        onError: AppPalette.white,
      ),
      scaffoldBackgroundColor: AppPalette.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.white,
        foregroundColor: AppPalette.black,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.yellow,
          foregroundColor: AppPalette.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.purple,
          side: const BorderSide(color: AppPalette.purple),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppPalette.purple,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPalette.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPalette.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPalette.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPalette.yellow, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPalette.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      cardTheme: CardTheme(
        color: AppPalette.grey,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppPalette.white,
        selectedItemColor: AppPalette.purple,
        unselectedItemColor: AppPalette.black,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppPalette.black,
        ),
        displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppPalette.black,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppPalette.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppPalette.black,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppPalette.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppPalette.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppPalette.black,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppPalette.darkGrey,
        ),
      ),
    );
  }
}
