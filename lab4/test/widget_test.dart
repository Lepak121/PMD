import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4/main.dart';
import 'package:lab4/widgets/action_buttons_widget.dart';
import 'package:lab4/widgets/header_widget.dart';
import 'package:lab4/widgets/image_block_widget.dart';
import 'package:lab4/widgets/info_card_widget.dart';

void main() {
  testWidgets('Лабораторна 4 - Перевірка власних віджетів StatelessWidget',
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

    // 2. Перевірка текстових елементів Пошук авто
    expect(find.text('Пошук авто: Audi A6 Sedan'), findsOneWidget);
    expect(find.text('ПОШУК АВТО'), findsOneWidget);
    expect(find.text('Характеристики'), findsOneWidget);
    expect(find.text('Контакти'), findsOneWidget);

    // 3. Перевірка layout-віджетів
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Spacer), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Padding), findsWidgets);

    // 4. Перевірка натискання кнопок
    await tester.tap(find.text('Характеристики'));
    await tester.pump();
    expect(find.text('Обрано: Характеристики авто'), findsOneWidget);
  });
}
