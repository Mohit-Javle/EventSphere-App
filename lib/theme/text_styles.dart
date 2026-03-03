import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Using Outfit as a modern geometric sans-serif replacement for Clash Display,
  // and DM Sans for body text as requested.
  
  static TextStyle get heading1 => GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      );

  static TextStyle get heading2 => GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      );

  static TextStyle get heading3 => GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyLarge => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
      
  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get button => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );
}
