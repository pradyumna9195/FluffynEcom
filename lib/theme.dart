import 'package:flutter/material.dart';

/// App theme configuration
class AppTheme {
  // Primary and accent colors
  static const Color primaryColor = Color(0xFF3F51B5); // Indigo
  static const Color secondaryColor = Color(0xFFFF9800); // Orange
  static const Color errorColor = Color(0xFFE53935); // Red
  static const Color successColor = Color(0xFF4CAF50); // Green

  // Text colors
  static const Color primaryTextColor = Color(0xFF212121);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color lightTextColor = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFEEEEEE);

  /// Light theme for the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        background: backgroundColor,
        onBackground: primaryTextColor,
        surface: cardColor,
        onSurface: primaryTextColor,
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: lightTextColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return primaryColor.withOpacity(0.3);
            }
            return primaryColor;
          }),
          foregroundColor: MaterialStateProperty.all(lightTextColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          elevation: MaterialStateProperty.all(1),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: dividerColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: dividerColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        labelStyle: const TextStyle(color: secondaryTextColor),
        hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: primaryTextColor,
          letterSpacing: 0.2,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: primaryTextColor,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: primaryTextColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: primaryTextColor),
        bodyMedium: TextStyle(fontSize: 14, color: primaryTextColor),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: primaryColor,
          letterSpacing: 0.5,
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: lightTextColor,
        elevation: 4,
      ),

      // Scaffold background color
      scaffoldBackgroundColor: backgroundColor,

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 24,
      ),

      // Snackbar theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: primaryColor,
        contentTextStyle: TextStyle(color: lightTextColor),
        actionTextColor: secondaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        circularTrackColor: dividerColor,
        linearTrackColor: dividerColor,
      ),
    );
  }

  /// Dark theme for the app (for future implementation)
  static ThemeData get darkTheme {
    // This is a placeholder for future dark theme implementation
    return lightTheme;
  }
}
