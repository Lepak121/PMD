import 'package:flutter/material.dart';
import '../widgets/action_buttons_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/image_block_widget.dart';
import '../widgets/info_card_widget.dart';

/// Лабораторна робота №4
/// Головний екран побудований на основі виділених власних віджетів (StatelessWidget)
/// та layout-віджетів: Column, Row, Container, Padding, Expanded, Spacer.
class Lab4Screen extends StatelessWidget {
  const Lab4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Пошук авто - Деталі',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
                firstButtonText: 'Характеристики',
                secondButtonText: 'Контакти',
                onFirstPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Обрано: Характеристики авто'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onSecondPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Обрано: Зв\'язок з продавцем'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // 2. Заголовок або верхній інформаційний блок — під кнопками
              const HeaderWidget(
                category: 'Пошук авто',
                title: 'Пошук авто: Audi A6 Sedan',
              ),

              const SizedBox(height: 12),

              // 3. Інформаційна картка / текстовий блок — у центральній частині
              const Expanded(
                child: InfoCardWidget(
                  mainDescription:
                      'Автомобіль у відмінному стані, офіційне обслуговування. '
                      'Повний привід Quattro, адаптивний круїз-контроль, матричні фари. '
                      'Шкіряний салон, аудіосистема Bang & Olufsen.',
                  studentNote:
                      'Використано окремий віджет InfoCardWidget (StatelessWidget) та Expanded.',
                ),
              ),

              const SizedBox(height: 16),

              // 4. Блок із зображенням або іконкою — внизу екрана
              const ImageBlockWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
                altText: 'Пошук авто: Audi A6',
                height: 190,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
