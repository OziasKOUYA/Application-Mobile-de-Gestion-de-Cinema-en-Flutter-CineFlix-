
import 'package:flutter/material.dart';

import '../../constantes/couleurs.dart';


class FuzFilledButtonTheme {
  FuzFilledButtonTheme._();//permet d'eviter la création d'instances

// theme claire

  static final lightFilledButtonTheme =FilledButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        foregroundColor: darkColorScheme.secondary,
        backgroundColor: darkColorScheme.secondary,
        disabledBackgroundColor: darkColorScheme.secondary,
        side: BorderSide(color: darkColorScheme.secondary),
        padding: const EdgeInsets.symmetric(vertical: 18),
        //textStyle: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

      )

  );

// theme sombre

  static final darkOutlinedButtonTheme =OutlinedButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        foregroundColor: darkColorScheme.secondary,
        backgroundColor: darkColorScheme.secondary,
        disabledBackgroundColor: darkColorScheme.secondary,
        side:  BorderSide(color: darkColorScheme.secondary),
        padding: const EdgeInsets.symmetric(vertical: 18),
       // textStyle:  TextStyle(fontSize: 16,color: darkColorScheme.secondary,fontWeight: FontWeight.w600),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

      )

  );
}