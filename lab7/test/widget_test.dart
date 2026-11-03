import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab7/main.dart';
import 'package:lab7/models/car_model.dart';
import 'package:lab7/screens/car_json_screen.dart';
import 'package:lab7/services/car_storage_service.dart';

void main() {
  test('CarModel fromJson and toJson serialization test', () {
    final json = {
      'id': 101,
      'title': 'Test Car',
      'isFavorite': true,
      'status': 'В наявності',
    };

    final car = CarModel.fromJson(json);
    expect(car.id, 101);
    expect(car.title, 'Test Car');
    expect(car.isFavorite, true);
    expect(car.status, 'В наявності');

    final backToJson = car.toJson();
    expect(backToJson['id'], 101);
    expect(backToJson['title'], 'Test Car');
    expect(backToJson['isFavorite'], true);
    expect(backToJson['status'], 'В наявності');
  });

  test('CarStorageService loads cars', () async {
    final service = CarStorageService();
    final cars = await service.loadCars();
    expect(cars.length, 5);
  });

  testWidgets('Лабораторна 7 - Тестування зчитування JSON, CRUD операцій та оновлення',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    final initialCars = [
      CarModel(
        id: 1,
        title: 'Audi A6 2.0 TFSI Quattro',
        isFavorite: true,
        status: 'В наявності',
      ),
      CarModel(
        id: 2,
        title: 'BMW 520d xDrive Sedan',
        isFavorite: false,
        status: 'Заброньовано',
      ),
      CarModel(
        id: 3,
        title: 'Mercedes-Benz E220d AMG',
        isFavorite: true,
        status: 'В наявності',
      ),
      CarModel(
        id: 4,
        title: 'Tesla Model 3 Long Range',
        isFavorite: false,
        status: 'Продано',
      ),
      CarModel(
        id: 5,
        title: 'Toyota Camry 2.5 Hybrid',
        isFavorite: false,
        status: 'В наявності',
      ),
    ];

    await tester.pumpWidget(MyApp(initialCars: initialCars));
    await tester.pump();

    // 1. Перевірка наявності екрана
    expect(find.byType(CarJsonScreen), findsOneWidget);
    expect(find.text('Пошук авто (JSON сховище)'), findsOneWidget);

    // 2. Перевірка завантажених початкових елементів з JSON
    expect(find.text('Audi A6 2.0 TFSI Quattro'), findsOneWidget);
    expect(find.text('BMW 520d xDrive Sedan'), findsOneWidget);
    expect(find.text('Mercedes-Benz E220d AMG'), findsOneWidget);

    // 3. Тест перемикання обраного ⭐
    expect(find.byIcon(Icons.star), findsNWidgets(2));
    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.star), findsNWidgets(3));

    // 4. Тест видалення елемента 🗑️
    final deleteButton = find.byIcon(Icons.delete_outline).first;
    await tester.tap(deleteButton);
    await tester.pump();
    expect(find.text('Audi A6 2.0 TFSI Quattro'), findsNothing);

    // 5. Тест додавання нового елемента
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AlertDialog, 'Додати авто (JSON)'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Назва авто'), 'Audi e-tron GT');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Зберегти в JSON'));
    await tester.pumpAndSettle();

    expect(find.text('Audi e-tron GT'), findsOneWidget);

    // 6. Тест редагування елемента ✏️
    final editButton = find.byIcon(Icons.edit_outlined).first;
    await tester.tap(editButton);
    await tester.pumpAndSettle();
    expect(find.text('Редагувати авто'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Назва авто'), 'BMW M5 Competition');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Оновити'));
    await tester.pumpAndSettle();

    expect(find.text('BMW M5 Competition'), findsOneWidget);
  });
}
