import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/car_model.dart';

/// Сервіс для роботи з JSON: зчитування з assets, десеріалізація,
/// збереження оновлених даних у локальний JSON-файл.
class CarStorageService {
  static const String _assetPath = 'assets/cars.json';
  static const String _localFileName = 'cars_saved.json';

  /// Отримання локального файлу для збереження оновлених даних
  File _getLocalFile() {
    final dir = Directory.systemTemp;
    return File('${dir.path}/$_localFileName');
  }

  /// Допоміжний метод читання початкового JSON (з assets або напряму з файлу)
  Future<String> _readInitialJson() async {
    try {
      return await rootBundle.loadString(_assetPath);
    } catch (_) {
      // Під час виконання unit/widget тестів rootBundle може не мати доступу до асетів
      final file = File(_assetPath);
      if (await file.exists()) {
        return await file.readAsString();
      }
      rethrow;
    }
  }

  /// Зчитування JSON та перетворення в `List<CarModel>`
  Future<List<CarModel>> loadCars() async {
    try {
      String jsonString;
      final localFile = _getLocalFile();

      // Якщо вже є збережений файл з оновленими даними — читаємо з нього
      if (!kIsWeb && await localFile.exists()) {
        jsonString = await localFile.readAsString();
      } else {
        // Інакше завантажуємо початковий JSON із ресурсів (assets)
        jsonString = await _readInitialJson();
      }

      // Перетворення JSON-масиву у `List<CarModel>`
      final List<dynamic> decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList
          .map((item) => CarModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Помилка завантаження JSON: $e');
      final jsonString = await _readInitialJson();
      final List<dynamic> decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList
          .map((item) => CarModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }

  /// Запис оновлених даних (`List<CarModel>`) у JSON-файл
  Future<void> saveCars(List<CarModel> cars) async {
    try {
      if (kIsWeb) return;

      final localFile = _getLocalFile();
      final List<Map<String, dynamic>> jsonList =
          cars.map((car) => car.toJson()).toList();
      final String jsonString =
          const JsonEncoder.withIndent('  ').convert(jsonList);

      await localFile.writeAsString(jsonString);
      debugPrint('Дані успішно збережено у JSON: ${localFile.path}');
    } catch (e) {
      debugPrint('Помилка запису у JSON-файл: $e');
    }
  }

  /// Скидання даних до початкових із assets/cars.json
  Future<List<CarModel>> resetToAssets() async {
    final localFile = _getLocalFile();
    if (!kIsWeb && await localFile.exists()) {
      await localFile.delete();
    }
    return loadCars();
  }
}
