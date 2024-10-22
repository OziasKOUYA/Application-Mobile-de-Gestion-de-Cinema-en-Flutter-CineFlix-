import 'package:flutter/material.dart';

class FuzBottomSheetTheme{
  FuzBottomSheetTheme._();
   static BottomSheetThemeData lightBottomSheetTheme=BottomSheetThemeData(
     showDragHandle: true,
     constraints: const BoxConstraints(minWidth: double.infinity),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
   );
  static BottomSheetThemeData darkBottomSheetTheme=BottomSheetThemeData(
    showDragHandle: true,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

}