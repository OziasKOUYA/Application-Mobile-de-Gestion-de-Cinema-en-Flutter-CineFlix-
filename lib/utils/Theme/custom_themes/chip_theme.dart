
import 'package:flutter/material.dart';

import '../../constantes/couleurs.dart';


class FuzChipTheme{
  FuzChipTheme._();
 static ChipThemeData lightChipTheme = ChipThemeData(
   disabledColor: darkColorScheme.secondary,
   labelStyle:  TextStyle(color:darkColorScheme.secondary),
   selectedColor:darkColorScheme.secondary,
   padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
   checkmarkColor: Colors.white,
 );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: darkColorScheme.secondary,
    labelStyle:  TextStyle(color:darkColorScheme.secondary),
    selectedColor: darkColorScheme.secondary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
    checkmarkColor: darkColorScheme.secondary,
  );

}