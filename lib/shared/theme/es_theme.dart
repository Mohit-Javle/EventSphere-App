import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'es_colors.dart';

class EsTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: EsColors.bgBase,
      primaryColor: EsColors.primary,
      
      textTheme: TextTheme(
        // Headings (Using Syne as fallback for Clash Display if not available via Google Fonts package)
        displayLarge: GoogleFonts.syne(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: EsColors.textPrimary,
        ),
        displayMedium: GoogleFonts.syne(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: EsColors.textPrimary,
        ),
        displaySmall: GoogleFonts.syne(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: EsColors.textPrimary,
        ),
        
        // Body (DM Sans)
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: EsColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: EsColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: EsColors.textSecondary,
        ),
        labelSmall: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: EsColors.textMuted,
        ),
        labelLarge: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: EsColors.textPrimary,
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: EsColors.bgElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: EsColors.bgBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: EsColors.bgBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: EsColors.primary),
        ),
        labelStyle: GoogleFonts.dmSans(color: EsColors.textSecondary),
        hintStyle: GoogleFonts.dmSans(color: EsColors.textMuted),
      ),
    );
  }
}
