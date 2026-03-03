import 'package:flutter/material.dart';

class EsColors {
  // Background levels
  static const Color bgBase = Color(0xFF0D0D14);
  static const Color bgSurface = Color(0xFF1A1A2E);
  static const Color bgElevated = Color(0xFF222238);
  static const Color bgBorder = Color(0xFF2A2A3E);

  // Brand
  static const Color primary = Color(0xFF6C3EF4);
  static const Color primaryLight = Color(0xFF8B5CF6);
  static const Color accent = Color(0xFFFF5C5C);
  static const Color accentOrange = Color(0xFFFF8C42);

  // Semantic
  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);
  static const Color info = Color(0xFF38BDF8);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0B8);
  static const Color textMuted = Color(0xFF555570);

  // Gradients
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment(-0.7, -0.7),
    end: Alignment(0.7, 0.7),
    colors: [Color(0xFF6C3EF4), Color(0xFF8B5CF6)],
  );

  static const LinearGradient gradientAccent = LinearGradient(
    begin: Alignment(-0.7, -0.7),
    end: Alignment(0.7, 0.7),
    colors: [Color(0xFFFF5C5C), Color(0xFFFF8C42)],
  );

  static const LinearGradient gradientCard = LinearGradient(
    begin: Alignment(-0.8, -0.8),
    end: Alignment(1.0, 1.0),
    colors: [Color(0xFF6C3EF4), Color(0xFF1A1A2E)],
    stops: [0.15, 1.0],
  );

  static const LinearGradient gradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0D0D14), Color(0xFF1A1A2E)],
  );
}
