import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: const Color(0xFFF4F7F8),

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF006B92),
        brightness: Brightness.light,
      ),

      textTheme: GoogleFonts.poppinsTextTheme(),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF4F7F8),
        foregroundColor: Color(0xFF172033),
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}