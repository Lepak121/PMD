import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab2/main.dart';

void main() {
  testWidgets('Перевірка відображення елементів інтерфейсу', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 1. Перевірка наявності Scaffold
    expect(find.byType(Scaffold), findsOneWidget);

    // 2. Перевірка AppBar з назвою "Пошук авто"
    expect(find.widgetWithText(AppBar, 'Пошук авто'), findsOneWidget);

    // 3. Перевірка віджета Center з кнопкою ElevatedButton ("Переглянути")
    expect(find.widgetWithText(ElevatedButton, 'Переглянути'), findsOneWidget);
    final elevatedButtonFinder = find.widgetWithText(ElevatedButton, 'Переглянути');
    expect(find.ancestor(of: elevatedButtonFinder, matching: find.byType(Center)), findsOneWidget);

    // 4. Перевірка BottomNavigationBar з 2 елементами
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.directions_car_outlined), findsOneWidget);

    // 5. Перевірка натискання кнопки "Переглянути"
    await tester.tap(find.widgetWithText(ElevatedButton, 'Переглянути'));
    await tester.pump();
    expect(find.text('Перегляд доступних авто...'), findsOneWidget);
  });
}
