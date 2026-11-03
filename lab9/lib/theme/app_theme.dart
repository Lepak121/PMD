import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

/// 1. Підтримка світлої та темної теми (Light / Dark mode)
/// 11. Забезпечення єдиного стилю оформлення (шрифт, кольори, форма карток, кнопок)
class AppTheme {
  AppTheme._();

  /// Світла тема
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppStyles.fontFamily,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: AppColors.surfaceLight,
        onSecondary: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        onError: AppColors.surfaceLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppStyles.titleMedium(isDark: false),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          side: const BorderSide(color: AppColors.dividerLight),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.primary,
        textColor: AppColors.textPrimaryLight,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.dividerLight;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withValues(alpha: 0.5);
          }
          return AppColors.borderLight;
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surfaceLight,
          textStyle: AppStyles.button(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.spacingLg,
            vertical: AppStyles.spacingMd,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: AppStyles.buttonOutlined(isDark: false),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.spacingLg,
            vertical: AppStyles.spacingMd,
          ),
        ),
      ),
    );
  }

  /// Темна тема
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppStyles.fontFamily,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: AppColors.backgroundDark,
        onSecondary: AppColors.backgroundDark,
        onSurface: AppColors.textPrimaryDark,
        onError: AppColors.surfaceLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppStyles.titleMedium(isDark: true),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          side: const BorderSide(color: AppColors.dividerDark),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.primaryLight,
        textColor: AppColors.textPrimaryDark,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent;
          }
          return AppColors.textMutedDark;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent.withValues(alpha: 0.4);
          }
          return AppColors.dividerDark;
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textPrimaryDark,
          textStyle: AppStyles.button(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.spacingLg,
            vertical: AppStyles.spacingMd,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight, width: 1.5),
          textStyle: AppStyles.buttonOutlined(isDark: true),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.spacingLg,
            vertical: AppStyles.spacingMd,
          ),
        ),
      ),
    );
  }
}
