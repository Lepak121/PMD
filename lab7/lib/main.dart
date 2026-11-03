import 'package:flutter/material.dart';
import 'models/car_model.dart';
import 'screens/car_json_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final List<CarModel>? initialCars;
  const MyApp({super.key, this.initialCars});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторна робота 7 - JSON сховище',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B),
        ),
      ),
      home: CarJsonScreen(initialCars: initialCars),
    );
  }
}
