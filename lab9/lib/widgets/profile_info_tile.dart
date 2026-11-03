import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

/// Віджет для відображення контактного або інформаційного рядка у картці профілю
class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final VoidCallback? onTap;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppStyles.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingMd,
          vertical: AppStyles.spacingSm + 2,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppStyles.spacingSm),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(AppStyles.radiusSm),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
            ),
            const SizedBox(width: AppStyles.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppStyles.subtitleSmall(isDark: isDark),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppStyles.bodyLarge(isDark: isDark).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.textMuted(isDark),
              ),
          ],
        ),
      ),
    );
  }
}
