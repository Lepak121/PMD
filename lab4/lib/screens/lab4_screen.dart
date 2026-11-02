import 'package:flutter/material.dart';
import '../widgets/action_buttons_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/image_block_widget.dart';
import '../widgets/info_card_widget.dart';

/// Головний екран Лабораторної роботи №4
/// Побудований на основі виділених власних віджетів (StatelessWidget)
/// та layout-віджетів: Column, Row, Container, Padding, Expanded, Spacer.
class Lab4Screen extends StatelessWidget {
  const Lab4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Деталі',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Блок кнопок дії — зверху (Row + Expanded)
              ActionButtonsWidget(
                firstButtonText: 'Дія 1',
                secondButtonText: 'Дія 2',
                onFirstPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Натиснуто: Дія 1'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onSecondPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Натиснуто: Дія 2'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // 2. Заголовок або верхній інформаційний блок — під кнопками
              const HeaderWidget(
                category: 'Пошук авто',
                title: 'Назва об\'єкта / запису',
              ),

              const SizedBox(height: 12),

              // 3. Інформаційна картка / текстовий блок — у центральній частині
              const Expanded(
                child: InfoCardWidget(
                  mainDescription:
                      'Детальний текст або примітки. Тут може бути більше інформації, '
                      'але без прокрутки. Expanded дозволяє цьому блоку зайняти вільний '
                      'простір між заголовком та зображенням.',
                  studentNote:
                      'Студент має слідкувати, щоб текст не виходив за межі екрана.',
                ),
              ),

              const SizedBox(height: 16),

              // 4. Блок із зображенням або іконкою — внизу екрана
              const ImageBlockWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
                altText: 'Пошук авто',
                height: 190,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
