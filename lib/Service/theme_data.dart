import 'package:clean_architecture/Constants/app_colors.dart';
import 'package:clean_architecture/Controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,

      //! AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundLight,
        surfaceTintColor: Colors.transparent,
      ),

      //! Card Theme
      cardTheme: CardTheme(
        color: AppColors.backgroundLight,
        shadowColor: AppColors.surface.withValues(alpha: 0.2),
      ),

      //! Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundLight,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      ),

      //! Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundLight,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),

      //! Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.backgroundDark),
        displayMedium: TextStyle(color: AppColors.backgroundDark),
        bodyLarge: TextStyle(color: AppColors.surface),
      ),

      //! Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor:
            WidgetStateProperty.resolveWith((states) => AppColors.primary),
      ),

      //! Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStateProperty.resolveWith((states) => AppColors.primary),
        trackColor:
            WidgetStateProperty.resolveWith((states) => AppColors.surface),
      ),

      //! Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.backgroundDark,
        contentTextStyle: const TextStyle(color: AppColors.backgroundLight),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
        alignedDropdown: true,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.primary,
      ));

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.surface,
        scaffoldBackgroundColor: AppColors.backgroundDark,

        //! AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          foregroundColor: AppColors.backgroundLight,
        ),

        //! Card Theme
        cardTheme: CardTheme(
          color: AppColors.surface,
          shadowColor: AppColors.backgroundDark,
        ),

        //! Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.backgroundLight,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),

        //! Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),

        //! Text Theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.backgroundLight),
          displayMedium: TextStyle(color: AppColors.backgroundLight),
          bodyLarge: TextStyle(color: AppColors.backgroundLight),
        ),

        //! Checkbox Theme
        checkboxTheme: CheckboxThemeData(
          fillColor:
              WidgetStateProperty.resolveWith((states) => AppColors.primary),
        ),

        //! Switch Theme
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
              (states) => AppColors.backgroundLight),
          trackColor:
              WidgetStateProperty.resolveWith((states) => AppColors.surface),
        ),

        //! Snackbar Theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.backgroundDark,
          contentTextStyle: const TextStyle(color: AppColors.backgroundLight),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primary,
          textTheme: ButtonTextTheme.normal,
          alignedDropdown: true,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primary,
          secondary: AppColors.primary,
        ),
      );

  //! Get the current theme based on the theme mode
  static ThemeData get currentTheme {
    final ThemeController themeController = Get.find<ThemeController>();
    return themeController.theme == ThemeMode.dark ? darkTheme : lightTheme;
  }
}
