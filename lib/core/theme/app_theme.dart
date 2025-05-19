import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFF5757FB),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDFDFDF),
    onPrimaryContainer: Color(0xFF001C38),

    secondary: Color(0xFF8F9A6D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE1E6B9),
    onSecondaryContainer: Color(0xFF202313),

    tertiary: Color(0xFFB0867A),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDBCF),
    onTertiaryContainer: Color(0xFF3E1E18),

    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFCFCFC),
    onSurface: Color(0xFF000000),

    surfaceContainerHighest: Color(0xFFE0E2EC),
    onSurfaceVariant: Color(0xFF44474E),

    outline: Color(0xFF74777F),
    outlineVariant: Color(0xFFC4C6CF),

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF4C4E53),
    onInverseSurface: Color(0xFFF3F3F3),
    inversePrimary: Color(0xFFA8C8FF),
    surfaceTint: Color(0xFF5D7A9E),
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF5D7A9E),
    onPrimary: Color(0xFF00315B),
    primaryContainer: Color(0xFF2C4771),
    onPrimaryContainer: Color(0xFFD6E3FF),

    secondary: Color(0xFFB7CFAA),
    onSecondary: Color(0xFF344834),
    secondaryContainer: Color(0xFF4B604B),
    onSecondaryContainer: Color(0xFFDDECDD),

    tertiary: Color(0xFFEABBAF),
    onTertiary: Color(0xFF4A221B),
    tertiaryContainer: Color(0xFF653B30),
    onTertiaryContainer: Color(0xFFFFDBCF),

    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF1A1C1E),
    onSurface: Color(0xFFE3E2E6),

    surfaceContainerHighest: Color(0xFF44474E),
    onSurfaceVariant: Color(0xFFC4C6CF),

    outline: Color(0xFF8E9199),
    outlineVariant: Color(0xFF44474E),

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE3E2E6),
    onInverseSurface: Color(0xFF1A1C1E),
    inversePrimary: Color(0xFF3A609E),
    surfaceTint: Color(0xFFA8C8FF),
  );

  static TextTheme _poppinsTextTheme(TextTheme baseTextTheme, ColorScheme colorScheme) {
    final onSurface = colorScheme.onSurface;

    return baseTextTheme.copyWith(
      displayLarge: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700, color: onSurface),
      headlineLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: onSurface),
      headlineMedium: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400, color: onSurface),
      headlineSmall: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: onSurface),
      titleLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: onSurface),
      titleMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: onSurface),
      bodyLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal, color: onSurface),
      titleSmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: onSurface),
      bodyMedium: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal, color: onSurface),
      labelMedium: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: onSurface),
      bodySmall: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400, color: onSurface),
      labelSmall: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.w400, color: onSurface),
      labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: onSurface),
    ).apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final baseTheme = ThemeData.from(colorScheme: colorScheme);
    final textTheme = _poppinsTextTheme(GoogleFonts.poppinsTextTheme(baseTheme.textTheme), colorScheme);

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
    );
  }

  static ThemeData lightTheme = _baseTheme(_lightColorScheme);
  static ThemeData darkTheme = _baseTheme(_darkColorScheme);
}