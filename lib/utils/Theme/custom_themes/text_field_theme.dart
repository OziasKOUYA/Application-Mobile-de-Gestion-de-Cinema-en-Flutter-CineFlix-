
import 'package:flutter/material.dart';

import '../../constantes/couleurs.dart';


class FuzTextFieldTheme {
  FuzTextFieldTheme._();

static InputDecorationTheme LightInputDecorationTheme =InputDecorationTheme(
  errorMaxLines: 3,
  prefixIconColor: lightColorScheme.onBackground,
  suffixIconColor: lightColorScheme.onBackground,

  labelStyle: const TextStyle().copyWith(fontSize: 14,color: lightColorScheme.onBackground),
  hintStyle: const TextStyle().copyWith(fontSize: 14,color:lightColorScheme.onBackground),
  errorStyle:const TextStyle().copyWith(fontStyle: FontStyle.normal),
  floatingLabelStyle: const TextStyle().copyWith(color:lightColorScheme.onBackground),
  border: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: lightColorScheme.primary),

  ),
  enabledBorder:  const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: lightColorScheme.primary),
  ),
  errorBorder:  const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide:  BorderSide(color:lightColorScheme.error)
  ),
  focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: lightColorScheme.error)
  ),
);

  static InputDecorationTheme DarkInputDecorationTheme =InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: darkColorScheme.onBackground,
    suffixIconColor: darkColorScheme.onBackground,

    labelStyle: const TextStyle().copyWith(fontSize: 14,color: darkColorScheme.onBackground),
    hintStyle: const TextStyle().copyWith(fontSize: 14,color:darkColorScheme.onBackground),
    errorStyle:const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color:darkColorScheme.onBackground),
    border:  const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: darkColorScheme.primary),
    ),
    enabledBorder:   const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: darkColorScheme.primary),

    ),
    errorBorder:  const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16),
        borderSide:  BorderSide(color:darkColorScheme.error)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16),
        borderSide:  BorderSide(color:darkColorScheme.error)
    ),
  );
}