import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4/main.dart';
import 'package:lab4/widgets/action_buttons_widget.dart';
import 'package:lab4/widgets/header_widget.dart';
import 'package:lab4/widgets/image_block_widget.dart';
import 'package:lab4/widgets/info_card_widget.dart';

void main() {
  testWidgets('Лабораторна 4 - Перевірка власних віджетів та компонентів',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());

    // 1. Перевірка наявності виділених компонентів (StatelessWidget)
    expect(find.byType(ActionButtonsWidget), findsOneWidget);
    expect(find.byType(HeaderWidget), findsOneWidget);
    expect(find.byType(InfoCardWidget), findsOneWidget);
    expect(find.byType(ImageBlockWidget), findsOneWidget);

    // 2. Перевірка текстових елементів
    expect(find.text('Деталі'), findsOneWidget);
    expect(find.text('Назва об\'єкта / запису'), findsOneWidget);
    expect(find.text('ПОШУК АВТО'), findsOneWidget);
    expect(find.text('Дія 1'), findsOneWidget);
    expect(find.text('Дія 2'), findsOneWidget);

    // 3. Перевірка використання layout-віджетів
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Spacer), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Padding), findsWidgets);

    // 4. Перевірка натискання кнопок
    await tester.tap(find.text('Дія 1'));
    await tester.pump();
    expect(find.text('Натиснуто: Дія 1'), findsOneWidget);
  });
}
