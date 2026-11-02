import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab3/main.dart';

void main() {
  testWidgets('Лабораторна 3 - Перевірка розміщення layout-віджетів', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());

    // Перевірка AppBar
    expect(find.widgetWithText(AppBar, 'Пошук авто - Деталі'), findsOneWidget);

    // Перевірка кнопок зверху (Row)
    expect(find.widgetWithText(OutlinedButton, 'Характеристики'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Контакти'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);

    // Перевірка заголовка Пошук авто
    expect(find.text('Пошук авто: Audi A6 Sedan'), findsOneWidget);

    // Перевірка наявності Expanded та Spacer
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Spacer), findsOneWidget);

    // Перевірка наявності Container для зображення
    expect(find.byType(Container), findsWidgets);

    // Перевірка натискання кнопки
    await tester.tap(find.widgetWithText(OutlinedButton, 'Характеристики'));
    await tester.pump();
    expect(find.text('Обрано: Характеристики авто'), findsOneWidget);
  });
}
