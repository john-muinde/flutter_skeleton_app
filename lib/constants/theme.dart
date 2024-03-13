import 'package:flutter/material.dart';
import 'package:study_buddy_app/constants/colors.dart';

class ThemeConstants {
  static ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: primarySwatch,
    backgroundColor: ColorPalette.secondaryIsabelline,
  );
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF6200EE,
    <int, Color>{
      50: Color(0xFFEDE7F6),
      100: Color(0xFFD1C4E9),
      200: Color(0xFFB39DDB),
      300: Color(0xFF9575CD),
      400: Color(0xFF7E57C2),
      500: Color(0xFF6200EE),
      600: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
      800: Color(0xFF4527A0),
      900: Color(0xFF311B92),
    },
  );

  static const ColorScheme colorScheme2 = ColorScheme(
    primary: Color(0xFF6200EE),
    secondary: Color(0xFF03DAC6),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    error: Color(0xFFB00020),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.light,
  );
  static ThemeData themeData = ThemeData(
    colorScheme: colorScheme,
    primarySwatch: primarySwatch,
    primaryColor: ColorPalette.backgroundCornflowerBlue,
    primaryColorDark: ColorPalette.primaryVariantCornflowerBlue,
    primaryColorLight: ColorPalette.backgroundCornflowerBlue,
    brightness: Brightness.light,
  );
}
