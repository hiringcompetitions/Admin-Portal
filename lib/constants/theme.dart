import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme() {
  final base = ThemeData.light();
  final baseTextTheme = base.textTheme;

  final poppinsTextTheme = GoogleFonts.poppinsTextTheme(baseTextTheme).copyWith(
    displayLarge: GoogleFonts.poppins(
      textStyle: baseTextTheme.displayLarge,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.poppins(
      textStyle: baseTextTheme.displayMedium,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: GoogleFonts.poppins(
      textStyle: baseTextTheme.displaySmall,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: GoogleFonts.poppins(
      textStyle: baseTextTheme.headlineLarge,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.poppins(
      textStyle: baseTextTheme.headlineMedium,
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: GoogleFonts.poppins(
      textStyle: baseTextTheme.headlineSmall,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.poppins(
      textStyle: baseTextTheme.titleLarge,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      textStyle: baseTextTheme.titleMedium,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.poppins(
      textStyle: baseTextTheme.titleSmall,
      color: const Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: GoogleFonts.poppins(
      textStyle: baseTextTheme.bodyLarge,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.poppins(
      textStyle: baseTextTheme.bodyMedium,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.poppins(
      textStyle: baseTextTheme.bodySmall,
      color: const Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.w300,
    ),
    labelLarge: GoogleFonts.inter(
      textStyle: baseTextTheme.labelLarge,
      color: Color(0xFF667085),
      fontWeight: FontWeight.w600,
    ),
    labelMedium: GoogleFonts.inter(
      textStyle: baseTextTheme.labelMedium,
      fontSize: 14,
      color: Color(0xFF667085),
      fontWeight: FontWeight.w100
    ),
    labelSmall: GoogleFonts.inter(
      textStyle: baseTextTheme.labelSmall,
      color: Color(0xFF667085),
      fontWeight: FontWeight.w400,
    ),
  );

  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily, // Enforce Poppins globally
    textTheme: poppinsTextTheme,
    
  );
}
