import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

/// 4. Графічні ресурси (зображення, аватар)
/// 5. Використання стандартних та власних іконок (PNG)
/// 6. Верхній блок ProfileScreen: аватар, ім’я, статус, бейдж
class ProfileHeader extends StatelessWidget {
  final String userName;
  final String status;
  final String roleBadge;
  final bool isDark;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.status,
    required this.roleBadge,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppStyles.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(AppStyles.radiusLg),
        border: Border.all(color: AppColors.divider(isDark)),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Декоративний банер із графічного ресурсу assets/images/header_bg.png
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppStyles.radiusLg),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/header_bg.png',
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 110,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
                // Власний бейдж (власна PNG іконка з assets/icons/custom_badge.png)
                Positioned(
                  top: AppStyles.spacingSm,
                  right: AppStyles.spacingSm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyles.spacingSm,
                      vertical: AppStyles.spacingXs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface(isDark).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(AppStyles.radiusFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/custom_badge.png',
                          width: 18,
                          height: 18,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.verified,
                              size: 18,
                              color: AppColors.accent,
                            );
                          },
                        ),
                        const SizedBox(width: AppStyles.spacingXs),
                        Text(
                          'PRO',
                          style: AppStyles.badge(
                            color: isDark ? AppColors.accent : AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Аватар користувача (графічний ресурс assets/images/avatar.png)
          Transform.translate(
            offset: const Offset(0, -45),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surface(isDark),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            userName.isNotEmpty ? userName[0] : '?',
                            style: AppStyles.titleLarge(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.spacingSm),

                // 6. Ім’я користувача з використанням AppStyles
                Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: AppStyles.titleLarge(isDark: isDark),
                ),
                const SizedBox(height: AppStyles.spacingXs),

                // 6. Короткий опис або статус
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spacingMd,
                  ),
                  child: Text(
                    status,
                    textAlign: TextAlign.center,
                    style: AppStyles.subtitle(isDark: isDark),
                  ),
                ),
                const SizedBox(height: AppStyles.spacingSm),

                // Тег ролі / групи
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spacingMd,
                    vertical: AppStyles.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppStyles.radiusFull),
                  ),
                  child: Text(
                    roleBadge,
                    style: TextStyle(
                      fontFamily: AppStyles.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
