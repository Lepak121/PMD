import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

/// 2. Перемикач теми (SwitchListTile)
/// Підтримує динамічне перемикання між світлою та темною темами (Light / Dark mode)
class ThemeToggleTile extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggle;

  const ThemeToggleTile({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface(isDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMd),
        side: BorderSide(color: AppColors.divider(isDark)),
      ),
      child: SwitchListTile(
        value: isDark,
        onChanged: onToggle,
        secondary: Container(
          padding: const EdgeInsets.all(AppStyles.spacingSm),
          decoration: BoxDecoration(
            color: (isDark ? AppColors.accent : AppColors.primary)
                .withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(AppStyles.radiusSm),
          ),
          child: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: isDark ? AppColors.accent : AppColors.primary,
          ),
        ),
        title: Text(
          isDark ? 'Темна тема' : 'Світла тема',
          style: AppStyles.titleSmall(isDark: isDark),
        ),
        subtitle: Text(
          isDark ? 'Активний темний режим інтерфейсу' : 'Активний світлий режим інтерфейсу',
          style: AppStyles.subtitleSmall(isDark: isDark),
        ),
      ),
    );
  }
}
