import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color gradientStart = Color(0xFF1E3C72); // deep blue

  static Color white20 = Colors.white.withAlpha((0.2 * 255).round());
  static Color white70 = Colors.white.withAlpha((0.7 * 255).round());

  static Color stroke = Color(0xFF0000004D).withAlpha((0.3 * 255).round());

  // Neutral Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF404040);

  //button colors
  static const Color buttonDarkGreen = Color(0xFF006837);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
}
