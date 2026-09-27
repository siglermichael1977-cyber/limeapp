import 'package:flutter/material.dart';

class LimeColors {
  // Primary gradient colors
  static const Color gradientStart = Color(0xFF0080FF); // Electric Blue
  static const Color gradientEnd = Color(0xFF00FF41);   // Neon Green
  static const Color primaryBlue = Color(0xFF0080FF);
  static const Color accentGreen = Color(0xFF00FF41);

  // Background colors
  static const Color background = Color(0xFFFAF9F5);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFF0F0C08);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);

  // Border colors
  static const Color borderLight = Color(0xFFF0EEE6);
  static const Color borderDark = Color(0xFFE8E6DC);

  // State colors
  static const Color unreadBackground = Color(0x1400FF41); // 8% opacity green
  static const Color hoverBackground = Color(0xFFFAF9F5);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF0080), accentGreen],
  );

  // Shadow
  static List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: primaryBlue.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 4),
    )
  ];
}
