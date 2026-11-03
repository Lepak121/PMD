import 'package:flutter/material.dart';

/// 7. Клас AppColors з власною палітрою кольорів
/// 8. Використовується у всьому застосунку замість Colors.blue, Colors.black тощо.
class AppColors {
  AppColors._();

  // Основний колір (primary)
  static const Color primary = Color(0xFF1E88E5); // Насичений синій
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF64B5F6);

  // Вторинний колір (secondary)
  static const Color secondary = Color(0xFF00897B); // Бірюзовий / смарагдовий
  static const Color secondaryDark = Color(0xFF00695C);
  static const Color secondaryLight = Color(0xFF4DB6AC);

  // Акцентний колір
  static const Color accent = Color(0xFFFFB300); // Теплий бурштиновий

  // Допоміжні кольори стану
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFB8C00);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF0288D1);

  // Кольори фону (light / dark)
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);

  static const Color backgroundDark = Color(0xFF121418);
  static const Color surfaceDark = Color(0xFF1E2229);
  static const Color cardDark = Color(0xFF262C36);

  // Кольори тексту
  static const Color textPrimaryLight = Color(0xFF1A1D20);
  static const Color textSecondaryLight = Color(0xFF606770);
  static const Color textMutedLight = Color(0xFF8D949E);

  static const Color textPrimaryDark = Color(0xFFF0F2F5);
  static const Color textSecondaryDark = Color(0xFFADB5BD);
  static const Color textMutedDark = Color(0xFF6C757D);

  // Розділювачі та рамки
  static const Color dividerLight = Color(0xFFE4E7EB);
  static const Color dividerDark = Color(0xFF2D333B);

  static const Color borderLight = Color(0xFFD0D7DE);
  static const Color borderDark = Color(0xFF374151);

  // Тіні
  static const Color shadowLight = Color(0x14000000);
  static const Color shadowDark = Color(0x33000000);

  // Допоміжні методи для адаптивного отримання кольорів за поточною темою
  static Color background(bool isDark) => isDark ? backgroundDark : backgroundLight;
  static Color surface(bool isDark) => isDark ? surfaceDark : surfaceLight;
  static Color card(bool isDark) => isDark ? cardDark : cardLight;
  static Color textPrimary(bool isDark) => isDark ? textPrimaryDark : textPrimaryLight;
  static Color textSecondary(bool isDark) => isDark ? textSecondaryDark : textSecondaryLight;
  static Color textMuted(bool isDark) => isDark ? textMutedDark : textMutedLight;
  static Color divider(bool isDark) => isDark ? dividerDark : dividerLight;
  static Color border(bool isDark) => isDark ? borderDark : borderLight;
}
