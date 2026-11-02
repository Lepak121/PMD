import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab3/main.dart';

void main() {
  testWidgets('Лабораторна 3 - Перевірка розміщення layout-віджетів', (WidgetTester tester) async {
    // Встановлюємо розмір тестового екрана
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());

    // Перевірка AppBar
    expect(find.widgetWithText(AppBar, 'Деталі'), findsOneWidget);

    // Перевірка кнопок зверху (Row)
    expect(find.widgetWithText(OutlinedButton, 'Дія 1'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Дія 2'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);

    // Перевірка заголовка
    expect(find.text('Назва об\'єкта / запису'), findsOneWidget);

    // Перевірка наявності Expanded та Spacer
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Spacer), findsOneWidget);

    // Перевірка наявності Container для зображення
    expect(find.byType(Container), findsWidgets);

    // Перевірка натискання кнопки Дія 1
    await tester.tap(find.widgetWithText(OutlinedButton, 'Дія 1'));
    await tester.pump();
    expect(find.text('Натиснуто: Дія 1'), findsOneWidget);
  });
}
