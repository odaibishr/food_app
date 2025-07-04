import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.border]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1),
    borderRadius: BorderRadius.circular(15),
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppPallete.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.background,
      elevation: 0,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    fontFamily: GoogleFonts.inter().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppPallete.white,
      filled: true,
      contentPadding: const EdgeInsets.all(14),
      border: _border(),
      prefixIconColor: AppPallete.main,
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.slate),
      errorBorder: _border(AppPallete.primary),
    ),
  );
}
