import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторна робота 3 - Пошук авто',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
      ),
      home: const CarDetailsScreen(),
    );
  }
}

/// Лабораторна робота №3
/// Група 3: Інформаційні блоки (Cards-first layout)
/// Макет:
///  ● кнопки — зверху (Row);
///  ● заголовок — під кнопками (Text);
///  ● опис — у центральній частині (Expanded);
///  ● зображення — внизу екрана (Container).
///
/// Основна структура: Пошук авто
/// Макет побудовано без використання списків та навігації,
/// використовуючи лише layout-віджети: Column, Row, Container, Padding, Expanded, Spacer.
class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

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
              // 1. Кнопки дії — зверху (Row з двома Expanded)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Натиснуто: Дія 1'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Дія 1',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Натиснуто: Дія 2'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Дія 2',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 2. Текстовий заголовок — під кнопками
              const Text(
                'Назва об\'єкта / запису',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // 3. Опис — у центральній частині (Expanded + Spacer для адаптивності)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Детальний текст або примітки. Тут може бути більше інформації, '
                      'але без прокрутки. Expanded дозволяє цьому блоку зайняти вільний '
                      'простір між заголовком та зображенням.\n\n'
                      'Студент має слідкувати, щоб текст не виходив за межі екрана.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.45,
                        color: Colors.black87,
                      ),
                    ),
                    // Використання Spacer для гнучкого розподілу простору
                    Spacer(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 4. Зображення — внизу екрана (Container із закругленими краями)
              Container(
                height: 200,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade200,
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.blueGrey.shade50,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_car, size: 64, color: Colors.blueGrey),
                            SizedBox(height: 8),
                            Text(
                              'Пошук авто',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
