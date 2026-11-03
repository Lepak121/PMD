import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 9. Клас AppStyles з визначенням типографіки, розмірів та стилів тексту
/// 10. Використовується у ProfileScreen та у всьому застосунку.
/// 11. Забезпечує єдиний стиль: спільний шрифт AppFont, кольори та узгоджені відступи.
class AppStyles {
  AppStyles._();

  // 3. Назва підключеного шрифту
  static const String fontFamily = 'AppFont';

  // Узгоджені відступи (Spacing & Dimensions)
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // Узгоджені радіуси заокруглення (Border Radius)
  static const double radiusSm = 8.0;
  static const double radiusMd = 14.0;
  static const double radiusLg = 20.0;
  static const double radiusFull = 999.0;

  // 9.1. Стилі для заголовків (Title)
  static TextStyle titleLarge({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.3,
        color: color ?? AppColors.textPrimary(isDark),
      );

  static TextStyle titleMedium({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.2,
        color: color ?? AppColors.textPrimary(isDark),
      );

  static TextStyle titleSmall({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color ?? AppColors.textPrimary(isDark),
      );

  // 9.2. Стилі для підзаголовків (Subtitle)
  static TextStyle subtitle({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: color ?? AppColors.textSecondary(isDark),
      );

  static TextStyle subtitleSmall({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color ?? AppColors.textMuted(isDark),
      );

  // 9.3. Стилі для основного тексту (Body)
  static TextStyle bodyLarge({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color ?? AppColors.textPrimary(isDark),
      );

  static TextStyle bodyMedium({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: color ?? AppColors.textSecondary(isDark),
      );

  static TextStyle bodySmall({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color ?? AppColors.textMuted(isDark),
      );

  // 9.4. Стиль для кнопок (Button)
  static TextStyle button({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: color ?? AppColors.surfaceLight,
      );

  static TextStyle buttonOutlined({bool isDark = false, Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: color ?? (isDark ? AppColors.primaryLight : AppColors.primary),
      );

  // Додаткові стилі: бейджі та статус
  static TextStyle badge({Color? color}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: color ?? AppColors.surfaceLight,
      );
}
