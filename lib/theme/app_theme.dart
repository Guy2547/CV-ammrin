import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const navy = Color(0xFF1E3A5F);
  static const blue = Color(0xFF2F6AA8);
  static const cream = Color(0xFFFFFBF2);
  static const lightBlue = Color(0xFFE8F0FA);
}

ThemeData buildTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.cream,
  );
  return base.copyWith(
    textTheme: GoogleFonts.promptTextTheme(base.textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.navy,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    ),
  );
}
