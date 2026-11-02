import 'package:flutter/material.dart';
import '../widgets/action_buttons_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/image_block_widget.dart';
import '../widgets/info_card_widget.dart';

/// Лабораторна робота №5
/// Екран реалізовано як StatefulWidget з окремим класом стану _Lab5ScreenState.
class Lab5Screen extends StatefulWidget {
  const Lab5Screen({super.key});

  @override
  State<Lab5Screen> createState() => _Lab5ScreenState();
}

/// Клас стану: всі змінні стану зберігаються всередині,
/// оновлення інтерфейсу виконується виключно через setState().
class _Lab5ScreenState extends State<Lab5Screen> {
  // Обов'язкові змінні стану:
  // 1. bool — стан іконки "обране" та стан Switch
  bool _isFavorite = false;
  bool _showExtraDetails = false;

  // 2. int — лічильник натискання кнопки дії
  int _actionCounter = 0;

  // 3. String — значення, введене у TextField
  String _userNote = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Деталі (Лабораторна 5)',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Блок кнопок дії (збільшує лічильник int через setState та відображає його)
              ActionButtonsWidget(
                firstButtonText: 'Переглянути',
                secondButtonText: 'Поділитися',
                counter: _actionCounter,
                onFirstPressed: () {
                  setState(() {
                    _actionCounter++;
                  });
                },
                onSecondPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Посилання скопійовано!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // 2. Заголовок з іконкою "обране" (bool) та бейджем статусу (Switch)
              HeaderWidget(
                category: 'Пошук авто',
                title: 'Назва об\'єкта / запису',
                isFavorite: _isFavorite,
                showBadge: _showExtraDetails,
                onFavoriteToggle: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),

              const SizedBox(height: 12),

              // 3. Інформаційна картка зі Switch (показ/приховування, бейдж) та TextField (onChanged)
              InfoCardWidget(
                mainDescription:
                    'Детальний текст або примітки. Тут може бути більше інформації. '
                    'Всі елементи стану інтерактивні та оновлюються через setState().',
                studentNote:
                    'Студент має слідкувати, щоб текст не виходив за межі екрана.',
                showExtraDetails: _showExtraDetails,
                onToggleExtraDetails: (bool value) {
                  setState(() {
                    _showExtraDetails = value;
                  });
                },
                userNote: _userNote,
                onNoteChanged: (String value) {
                  setState(() {
                    _userNote = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // 4. Блок із зображенням або іконкою внизу екрана
              const ImageBlockWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
                altText: 'Пошук авто',
                height: 170,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
