import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab9/main.dart';
import 'package:lab9/screens/profile_screen.dart';
import 'package:lab9/theme/app_colors.dart';
import 'package:lab9/theme/app_styles.dart';

void main() {
  test('AppColors and AppStyles consistency test', () {
    expect(AppStyles.fontFamily, 'AppFont');
    expect(AppColors.primary, const Color(0xFF1E88E5));
    expect(AppColors.secondary, const Color(0xFF00897B));

    // Перевірка адаптивних геттерів для світлої та темної тем
    expect(AppColors.background(false), AppColors.backgroundLight);
    expect(AppColors.background(true), AppColors.backgroundDark);
    expect(AppColors.textPrimary(false), AppColors.textPrimaryLight);
    expect(AppColors.textPrimary(true), AppColors.textPrimaryDark);

    // Перевірка створення текстових стилів
    final titleStyle = AppStyles.titleLarge(isDark: false);
    expect(titleStyle.fontFamily, 'AppFont');
    expect(titleStyle.fontSize, 24);
    expect(titleStyle.fontWeight, FontWeight.w700);

    final buttonStyle = AppStyles.button();
    expect(buttonStyle.fontFamily, 'AppFont');
    expect(buttonStyle.fontWeight, FontWeight.w600);
  });

  testWidgets('Лабораторна 9 - Відображення ProfileScreen та перемикання тем',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp(initialThemeMode: ThemeMode.light));
    await tester.pumpAndSettle();

    // 1. Перевірка наявності екрана ProfileScreen
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Мій профіль'), findsOneWidget);

    // 2. Перевірка даних користувача (аватар, ім’я, статус, бейдж)
    expect(find.text('Юрій Лепак'), findsOneWidget);
    expect(
      find.text('Студент групи КН-2327Б • Flutter & Mobile Developer'),
      findsOneWidget,
    );
    expect(find.text('Група КН-2327Б'), findsOneWidget);

    // 3. Перевірка контактної інформації
    expect(find.text('yuriy.lepak@pmd.edu'), findsOneWidget);
    expect(find.text('+380 67 123 45 67'), findsOneWidget);
    expect(find.text('Львів, Україна'), findsOneWidget);

    // 4. Початковий стан: Світла тема
    expect(find.text('Світла тема'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    final Switch switchWidgetLight = tester.widget(switchFinder);
    expect(switchWidgetLight.value, isFalse);

    // 5. Перемикання теми через SwitchListTile на темну (Dark mode)
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();

    expect(find.text('Темна тема'), findsOneWidget);
    final Switch switchWidgetDark = tester.widget(switchFinder);
    expect(switchWidgetDark.value, isTrue);

    // 6. Перемикання назад на світлу через іконку в AppBar
    final themeActionIcon = find.byTooltip('Перемкнути на світлу');
    expect(themeActionIcon, findsOneWidget);
    await tester.tap(themeActionIcon);
    await tester.pumpAndSettle();

    expect(find.text('Світла тема'), findsOneWidget);

    // 7. Перевірка відкриття діалогу виходу з акаунта
    await tester.ensureVisible(find.text('Вийти з акаунта'));
    await tester.tap(find.text('Вийти з акаунта'));
    await tester.pumpAndSettle();

    expect(find.text('Вихід з облікового запису'), findsOneWidget);
    expect(find.text('Скасувати'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Вийти'), findsOneWidget);

    // Закриття діалогу
    await tester.tap(find.text('Скасувати'));
    await tester.pumpAndSettle();
    expect(find.text('Вихід з облікового запису'), findsNothing);
  });
}
