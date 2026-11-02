import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab6/main.dart';
import 'package:lab6/screens/car_list_screen.dart';

void main() {
  testWidgets('Лабораторна 6 - Тестування списку, додавання, видалення та статистики',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());

    // 1. Перевірка наявності екрана та заголовка
    expect(find.byType(CarListScreen), findsOneWidget);
    expect(find.text('Пошук авто (Каталог)'), findsOneWidget);

    // 2. Перевірка початкових 5 елементів
    expect(find.text('Audi A6 2.0 TFSI Quattro'), findsOneWidget);
    expect(find.text('BMW 520d xDrive Sedan'), findsOneWidget);
    expect(find.text('Mercedes-Benz E220d AMG'), findsOneWidget);
    expect(find.text('Volkswagen Passat B8 R-Line'), findsOneWidget);
    expect(find.text('Toyota Camry 2.5 Hybrid'), findsOneWidget);

    // 3. Перевірка статистики Map<String, int>
    expect(find.text('5'), findsOneWidget); // Всього 5
    expect(find.text('2'), findsOneWidget); // Обраних 2

    // 4. Тест зміни обраного (toggle isFavorite)
    expect(find.byIcon(Icons.star), findsNWidgets(2)); // 2 обрані спочатку

    // Перемикаємо перше неокреме авто (BMW)
    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.star), findsNWidgets(3)); // Тепер 3 обрані

    // 5. Тест видалення автомобіля
    final deleteButtons = find.byIcon(Icons.delete_outline);
    await tester.tap(deleteButtons.first);
    await tester.pump();
    expect(find.text('Audi A6 2.0 TFSI Quattro'), findsNothing);
    expect(find.text('4'), findsWidgets); // Тепер всього 4

    // 6. Тест відкриття діалогу додавання
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Додати автомобіль'), findsOneWidget);

    // Вводимо назву та натискаємо Додати
    await tester.enterText(find.widgetWithText(TextField, 'Марка та модель'), 'Tesla Model 3');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Додати'));
    await tester.pumpAndSettle();

    expect(find.text('Tesla Model 3'), findsOneWidget);
  });
}
