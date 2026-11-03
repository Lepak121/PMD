import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_tile.dart';
import '../widgets/theme_toggle_tile.dart';

/// 6. Екран профілю користувача ProfileScreen
class ProfileScreen extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeToggle;

  const ProfileScreen({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  // Діалог підтвердження виходу
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(isDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMd),
        ),
        title: Row(
          children: [
            const Icon(Icons.logout, color: AppColors.error),
            const SizedBox(width: AppStyles.spacingSm),
            Expanded(
              child: Text(
                'Вихід з облікового запису',
                style: AppStyles.titleMedium(isDark: isDark),
              ),
            ),
          ],
        ),
        content: Text(
          'Ви впевнені, що бажаєте вийти з поточного профілю?',
          style: AppStyles.bodyMedium(isDark: isDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Скасувати',
              style: TextStyle(
                fontFamily: AppStyles.fontFamily,
                color: AppColors.textSecondary(isDark),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.surfaceLight,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Сесію завершено'),
                  backgroundColor: AppColors.error,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Вийти'),
          ),
        ],
      ),
    );
  }

  // Діалог перегляду детальної інформації
  void _showDetailDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(isDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMd),
        ),
        title: Text(title, style: AppStyles.titleMedium(isDark: isDark)),
        content: Text(content, style: AppStyles.bodyMedium(isDark: isDark)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Зрозуміло',
              style: TextStyle(
                fontFamily: AppStyles.fontFamily,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(isDark),
      appBar: AppBar(
        title: const Text('Мій профіль'),
        centerTitle: true,
        backgroundColor: AppColors.surface(isDark),
        foregroundColor: AppColors.textPrimary(isDark),
        elevation: 0,
        actions: [
          // Швидка кнопка зміни теми в AppBar
          IconButton(
            tooltip: isDark ? 'Перемкнути на світлу' : 'Перемкнути на темну',
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? AppColors.accent : AppColors.primary,
            ),
            onPressed: () => onThemeToggle(!isDark),
          ),
          IconButton(
            tooltip: 'Налаштування',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showDetailDialog(
              context,
              'Налаштування',
              'Розділ налаштувань профілю та параметрів застосунку.',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppStyles.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 4, 6. Верхній блок: аватар, банер, ім’я, статус
              ProfileHeader(
                userName: 'Юрій Лепак',
                status: 'Студент групи КН-2327Б • Flutter & Mobile Developer',
                roleBadge: 'Група КН-2327Б',
                isDark: isDark,
              ),

              // 2, 6. Секція теми: Switch / SwitchListTile
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.spacingMd,
                ),
                child: ThemeToggleTile(
                  isDark: isDark,
                  onToggle: onThemeToggle,
                ),
              ),

              const SizedBox(height: AppStyles.spacingMd),

              // 6. Контактна інформація (email, телефон, місто)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.spacingMd,
                ),
                child: _buildCardSection(
                  title: 'Контактна інформація',
                  children: [
                    ProfileInfoTile(
                      icon: Icons.email_outlined,
                      label: 'Email адреса',
                      value: 'yuriy.lepak@pmd.edu',
                      isDark: isDark,
                      onTap: () => _showDetailDialog(
                        context,
                        'Email',
                        'Основна контактна адреса: yuriy.lepak@pmd.edu',
                      ),
                    ),
                    Divider(color: AppColors.divider(isDark), height: 1),
                    ProfileInfoTile(
                      icon: Icons.phone_outlined,
                      label: 'Телефон',
                      value: '+380 67 123 45 67',
                      isDark: isDark,
                      onTap: () => _showDetailDialog(
                        context,
                        'Телефон',
                        'Контактний номер телефону: +380 67 123 45 67',
                      ),
                    ),
                    Divider(color: AppColors.divider(isDark), height: 1),
                    ProfileInfoTile(
                      icon: Icons.location_on_outlined,
                      label: 'Місто / Локація',
                      value: 'Львів, Україна',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spacingMd),

              // 6. Іконки для оформлення (профіль, налаштування, безпека, сповіщення, вихід)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.spacingMd,
                ),
                child: _buildCardSection(
                  title: 'Налаштування та безпека',
                  children: [
                    _buildActionTile(
                      context: context,
                      icon: Icons.badge_outlined,
                      title: 'Редагувати особисті дані',
                      subtitle: 'Зміна імені, статусу та фотографії',
                      onTap: () => _showDetailDialog(
                        context,
                        'Редагування даних',
                        'Форма для зміни імені та фотографії профілю.',
                      ),
                    ),
                    Divider(color: AppColors.divider(isDark), height: 1),
                    _buildActionTile(
                      context: context,
                      icon: Icons.notifications_outlined,
                      title: 'Сповіщення',
                      subtitle: 'Управління push-повідомленнями',
                      onTap: () => _showDetailDialog(
                        context,
                        'Сповіщення',
                        'Усі сповіщення активовані.',
                      ),
                    ),
                    Divider(color: AppColors.divider(isDark), height: 1),
                    _buildActionTile(
                      context: context,
                      icon: Icons.shield_outlined,
                      title: 'Конфіденційність та безпека',
                      subtitle: 'Пароль, двофакторна автентифікація',
                      onTap: () => _showDetailDialog(
                        context,
                        'Безпека',
                        'Двофакторна автентифікація підключена.',
                      ),
                    ),
                    Divider(color: AppColors.divider(isDark), height: 1),
                    _buildActionTile(
                      context: context,
                      icon: Icons.help_outline,
                      title: 'Допомога та підтримка',
                      subtitle: 'FAQ та зв’язок із розробником',
                      onTap: () => _showDetailDialog(
                        context,
                        'Довідка',
                        'Лабораторна робота №9: Теми, кастомні шрифти, AppColors, AppStyles.',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spacingMd),

              // 6. Кнопка виходу (Logout)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.spacingMd,
                ),
                child: Material(
                  color: AppColors.surface(isDark),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyles.radiusMd),
                    side: BorderSide(
                      color: AppColors.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(AppStyles.spacingSm),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppStyles.radiusSm),
                      ),
                      child: const Icon(
                        Icons.logout,
                        color: AppColors.error,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      'Вийти з акаунта',
                      style: AppStyles.titleSmall(
                        color: AppColors.error,
                      ),
                    ),
                    subtitle: Text(
                      'Завершити поточну сесію користувача',
                      style: AppStyles.subtitleSmall(isDark: isDark),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.error,
                      size: 20,
                    ),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Спільний контейнер для секцій карток
  Widget _buildCardSection({
    required String title,
    required List<Widget> children,
  }) {
    return Material(
      color: AppColors.surface(isDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMd),
        side: BorderSide(color: AppColors.divider(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppStyles.spacingMd,
              AppStyles.spacingMd,
              AppStyles.spacingMd,
              AppStyles.spacingSm,
            ),
            child: Text(
              title,
              style: AppStyles.titleSmall(isDark: isDark),
            ),
          ),
          Divider(color: AppColors.divider(isDark), height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppStyles.spacingSm),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.primaryLight : AppColors.primary)
              .withValues(alpha: isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(AppStyles.radiusSm),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: AppStyles.bodyLarge(isDark: isDark).copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyles.subtitleSmall(isDark: isDark),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: AppColors.textMuted(isDark),
      ),
      onTap: onTap,
    );
  }
}
