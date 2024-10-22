
import 'package:flutter/material.dart';

import '../../constantes/couleurs.dart';
class FuzTextTheme{
  FuzTextTheme._();
  //theme de texte mode clair modifiable
   static TextTheme lightTextTheme = TextTheme(

     headlineLarge: const TextStyle().copyWith(fontSize:50.0,fontWeight: FontWeight.w500, color:lightColorScheme.onBackground ),
     headlineMedium: const TextStyle().copyWith(fontSize:24.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground ),
     headlineSmall: const TextStyle().copyWith(fontSize:18.0,fontWeight: FontWeight.w500,color:lightColorScheme.onBackground ),

     titleLarge: const TextStyle().copyWith(fontSize:16.0,fontWeight: FontWeight.w500, color:lightColorScheme.onBackground ),
     titleMedium: const TextStyle().copyWith(fontSize:14.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground ),
     titleSmall: const TextStyle().copyWith(fontSize:12.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground ),

     bodyLarge: const TextStyle().copyWith(fontSize:13.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground ),
     bodyMedium: const TextStyle().copyWith(fontSize:12.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground ),
     bodySmall: const TextStyle().copyWith(fontSize:8.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground ),

     labelLarge: const TextStyle().copyWith(fontSize:12.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground),
     labelMedium: const TextStyle().copyWith(fontSize:12.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground),
     labelSmall: const TextStyle().copyWith(fontSize:12.0,fontWeight:  FontWeight.w500, color:lightColorScheme.onBackground),
   );

  //theme de texte mode sombre modifiable
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize:32.0,fontWeight: FontWeight.w500, color:darkColorScheme.onBackground),
    headlineMedium: const TextStyle().copyWith(fontSize:24.0,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),
    headlineSmall: const TextStyle().copyWith(fontSize:18.0,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),

    titleLarge: const TextStyle().copyWith(fontSize:14.0,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),
    titleMedium: const TextStyle().copyWith(fontSize:14.0,fontWeight: FontWeight.w500, color:darkColorScheme.onBackground),
    titleSmall: const TextStyle().copyWith(fontSize:10.5,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),

    bodyLarge: const TextStyle().copyWith(fontSize:12.0,fontWeight: FontWeight.w500, color:darkColorScheme.onBackground),
    bodyMedium: const TextStyle().copyWith(fontSize:12.0,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),
    bodySmall: const TextStyle().copyWith(fontSize:8.0,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),

    labelLarge: const TextStyle().copyWith(fontSize:10.0,fontWeight: FontWeight.w500, color:darkColorScheme.onBackground),
    labelMedium: const TextStyle().copyWith(fontSize:9.0,fontWeight: FontWeight.w500, color:darkColorScheme.onBackground),
    labelSmall: const TextStyle().copyWith(fontSize:8.0,fontWeight:  FontWeight.w500, color:darkColorScheme.onBackground),
  );
}