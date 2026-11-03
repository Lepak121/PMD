import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab8/main.dart';
import 'package:lab8/screens/home_screen.dart';
import 'package:lab8/screens/register_screen.dart';

void main() {
  testWidgets('Лабораторна 8 - Тестування валідації форми та навігації на HomeScreen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // 1. Перевірка наявності екрана реєстрації
    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.text('Реєстрація користувача'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(5));

    // 2. Спроба відправки порожньої форми (повинні з'явитися помилки валідації)
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Зареєструватися'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Зареєструватися'));
    await tester.pumpAndSettle();

    expect(find.text('Будь ласка, введіть ім’я користувача'), findsOneWidget);
    expect(find.text('Будь ласка, вкажіть дату народження'), findsOneWidget);
    expect(find.text('Будь ласка, введіть email'), findsOneWidget);
    expect(find.text('Будь ласка, введіть пароль'), findsOneWidget);
    expect(find.text('Будь ласка, підтвердіть пароль'), findsOneWidget);

    // HomeScreen ще НЕ повинен відкритися
    expect(find.byType(HomeScreen), findsNothing);

    // 3. Тест валідації короткого імені (< 3 символів)
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Ім’я користувача *'), 'Юр');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Зареєструватися'));
    await tester.pumpAndSettle();
    expect(find.text('Ім’я повинно містити не менше 3 символів'), findsOneWidget);

    // 4. Тест валідації невідповідності паролів
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Пароль *'), '123456');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Підтвердження пароля *'), '654321');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Зареєструватися'));
    await tester.pumpAndSettle();
    expect(find.text('Паролі не збігаються'), findsOneWidget);

    // 5. Введення коректних даних у всі поля
    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Юрій');
    await tester.enterText(textFields.at(1), '15.05.2002');
    await tester.enterText(textFields.at(2), 'lepak@gmail.com');
    await tester.enterText(textFields.at(3), 'secret123');
    await tester.enterText(textFields.at(4), 'secret123');

    // 6. Відправка форми після успішної валідації
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Зареєструватися'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Зареєструватися'));
    await tester.pumpAndSettle();

    // 7. Перевірка навігації на HomeScreen та привітання з переданим іменем
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Вітаємо, Юрій!'), findsOneWidget);
  });
}
