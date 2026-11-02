import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Пошук авто',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const CarSearchScreen(),
    );
  }
}

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({super.key});

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 1. Використання віджета Scaffold для побудови головного екрана застосунку
    return Scaffold(
      // 2. AppBar з назвою застосунку відповідно до обраного варіанту ("Пошук авто")
      appBar: AppBar(
        title: const Text(
          'Пошук авто',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),

      // 3. Реалізація в тілі екрана віджета Center з кнопкою ElevatedButton ("Переглянути")
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Перегляд доступних авто...'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Переглянути'),
        ),
      ),

      // 4. BottomNavigationBar, що містить два BottomNavigationBarItem:
      // ○ текстовий пункт із назвою відповідно до теми ("Авто");
      // ○ пункт з іконкою відповідно до теми (авто).
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          // Пункт 1: текстовий пункт із назвою відповідно до теми ("Авто")
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_outlined),
            activeIcon: Icon(Icons.text_snippet),
            label: 'Авто',
          ),
          // Пункт 2: пункт з іконкою або зображенням відповідно до теми (авто)
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            activeIcon: Icon(Icons.directions_car),
            label: 'Авто',
          ),
        ],
      ),
    );
  }
}
