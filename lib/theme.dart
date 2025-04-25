import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pet-friendly App theme configuration with playful and warm elements
class AppTheme {
  // Primary and accent colors - pet-friendly palette
  static const Color primaryColor = Color(0xFF4CAF92); // Teal green
  static const Color secondaryColor = Color(0xFFF5A623); // Warm orange
  static const Color accentColor = Color(0xFF8BC34A); // Light green
  static const Color neutralColor = Color(0xFF606060); // Warm grey

  // Semantic colors
  static const Color errorColor = Color(0xFFFF5252); // Bright red
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color warningColor = Color(0xFFFFB74D); // Orange

  // Text colors
  static const Color primaryTextColor = Color(0xFF303030);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color lightTextColor = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFEEEEEE);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xFF66BB8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, Color(0xFFFFCC80)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Light theme for the app
  static ThemeData get lightTheme {
    final baseTextTheme =
        GoogleFonts.quicksandTextTheme(); // Playful, rounded font

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        background: backgroundColor,
        onBackground: primaryTextColor,
        surface: cardColor,
        onSurface: primaryTextColor,
      ),

      // Typography with Google Fonts - using Quicksand for a friendly, rounded look
      textTheme: TextTheme(
        headlineLarge: baseTextTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: primaryTextColor,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: primaryTextColor,
          letterSpacing: -0.5,
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: primaryTextColor,
        ),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: primaryTextColor,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: primaryTextColor,
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: primaryTextColor,
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: primaryColor,
          letterSpacing: 0.5,
        ),
      ),

      // AppBar theme - playful and pet-friendly
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: lightTextColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.quicksand(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: lightTextColor,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      // Card theme - more rounded corners for a playful feel
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      // Elevated button theme - playful and rounded
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
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          elevation: MaterialStateProperty.all(2),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.1),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ),

      // Input decoration theme - playful and pet-friendly
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        labelStyle: GoogleFonts.quicksand(
          color: secondaryTextColor,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.quicksand(
          color: secondaryTextColor.withOpacity(0.7),
        ),
        floatingLabelStyle: GoogleFonts.quicksand(
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Floating action button theme - playful paw print icon
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: lightTextColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Scaffold background color
      scaffoldBackgroundColor: backgroundColor,

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 24,
      ),

      // Snackbar theme - playful and rounded
      snackBarTheme: SnackBarThemeData(
        backgroundColor: neutralColor.withOpacity(0.9),
        contentTextStyle: GoogleFonts.quicksand(
          color: lightTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionTextColor: secondaryColor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        circularTrackColor: dividerColor,
        linearTrackColor: dividerColor,
      ),

      // Icon theme
      iconTheme: const IconThemeData(color: primaryColor, size: 24),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  /// Dark theme for the app
  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.quicksandTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        background: const Color(0xFF121212),
        onBackground: Colors.white,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
      ),

      // Typography with Google Fonts - using Quicksand for a friendly, rounded look
      textTheme: TextTheme(
        headlineLarge: baseTextTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.white,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: Colors.white,
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: primaryColor,
          letterSpacing: 0.5,
        ),
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.quicksand(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      // CardTheme
      cardTheme: CardTheme(
        color: const Color(0xFF2A2A2A),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          elevation: MaterialStateProperty.all(2),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.1),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        labelStyle: GoogleFonts.quicksand(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.quicksand(color: Colors.white60),
        floatingLabelStyle: GoogleFonts.quicksand(
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Scaffold background color
      scaffoldBackgroundColor: const Color(0xFF121212),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF3A3A3A),
        thickness: 1,
        space: 24,
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF303030),
        contentTextStyle: GoogleFonts.quicksand(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionTextColor: secondaryColor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        circularTrackColor: Color(0xFF3A3A3A),
        linearTrackColor: Color(0xFF3A3A3A),
      ),

      // Icon theme
      iconTheme: const IconThemeData(color: primaryColor, size: 24),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
