import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab5/main.dart';
import 'package:lab5/screens/lab5_screen.dart';

void main() {
  testWidgets('Лабораторна 5 - Перевірка стану StatefulWidget та інтерактивних елементів',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());

    // 1. Перевірка наявності StatefulWidget екрана
    expect(find.byType(Lab5Screen), findsOneWidget);

    // 2. Тест кнопки дії (збільшення int лічильника)
    expect(find.text('Переглянути (0)'), findsOneWidget);
    await tester.tap(find.text('Переглянути (0)'));
    await tester.pump();
    expect(find.text('Переглянути (1)'), findsOneWidget);

    // 3. Тест іконки "обране" (bool стан та зміна іконки)
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // 4. Тест Switch (показ прихованого блоку та поява бейджа)
    expect(find.text('В НАЯВНОСТІ'), findsNothing);
    expect(find.text('• Двигун: 2.0 TFSI (245 к.с.)\n• Привід: Повний (Quattro)\n• Колір: Чорний металік (Mythos Black)'), findsNothing);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.text('В НАЯВНОСТІ'), findsOneWidget);

    // 5. Тест TextField (зчитування через onChanged та відображення результату)
    expect(find.textContaining('Збережена замітка:'), findsNothing);
    await tester.enterText(find.byType(TextField), 'Чудовий стан авто!');
    await tester.pump();
    expect(find.text('Збережена замітка: Чудовий стан авто!'), findsOneWidget);
  });
}
