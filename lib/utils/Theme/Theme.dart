
import 'package:flutter/material.dart';

import '../constantes/couleurs.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/text_Theme.dart';
import 'custom_themes/text_field_theme.dart';


import 'package:google_fonts/google_fonts.dart';

class FuzAppTheme {
  FuzAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: GoogleFonts.pompiere().fontFamily, // Utilisation de la police Pompiere
    brightness: Brightness.light,
    primaryColor: lightColorScheme.primary,
    textTheme: GoogleFonts.pompiereTextTheme(), // Application de Pompiere à tout le texte
    chipTheme: FuzChipTheme.lightChipTheme,
    appBarTheme: FuzAppbarTheme.lightAppbarTheme,
    bottomSheetTheme: FuzBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: FuzTextFieldTheme.LightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: GoogleFonts.pompiere().fontFamily, // Utilisation de la police Pompiere
    brightness: Brightness.dark,
    primaryColor: darkColorScheme.primary,
    textTheme: GoogleFonts.pompiereTextTheme(), // Application de Pompiere à tout le texte
    chipTheme: FuzChipTheme.darkChipTheme,
    appBarTheme: FuzAppbarTheme.darkAppbarTheme,
    bottomSheetTheme: FuzBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: FuzTextFieldTheme.DarkInputDecorationTheme,
  );
}
