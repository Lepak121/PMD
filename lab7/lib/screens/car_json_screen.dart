import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../services/car_storage_service.dart';

/// Лабораторна робота №7
/// Робота з JSON: зчитування з assets, десеріалізація через fromJson(),
/// серіалізація через toJson(), збереження у JSON-файл, CRUD операції в ListView.builder.
class CarJsonScreen extends StatefulWidget {
  final List<CarModel>? initialCars;
  const CarJsonScreen({super.key, this.initialCars});

  @override
  State<CarJsonScreen> createState() => _CarJsonScreenState();
}

class _CarJsonScreenState extends State<CarJsonScreen> {
  final CarStorageService _storageService = CarStorageService();

  List<CarModel> _cars = [];
  bool _isLoading = true;

  final List<String> _availableStatuses = [
    'В наявності',
    'Заброньовано',
    'Продано',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCars != null) {
      _cars = List.from(widget.initialCars!);
      _isLoading = false;
    } else {
      _loadInitialData();
    }
  }

  // 4, 7. Завантаження JSON з assets/файлу та перетворення в List<CarModel>
  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    final cars = await _storageService.loadCars();
    setState(() {
      _cars = cars;
      _isLoading = false;
    });
  }

  // 13. Збереження списку у локальний JSON-файл
  Future<void> _saveData() async {
    await _storageService.saveCars(_cars);
  }

  // 12. Перемикання стану обраного (isFavorite)
  void _toggleFavorite(int index) {
    setState(() {
      _cars[index].isFavorite = !_cars[index].isFavorite;
    });
    _saveData();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _cars[index].isFavorite
              ? 'Додано в обране: ${_cars[index].title}'
              : 'Видалено з обраного: ${_cars[index].title}',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // 11. Видалення елемента зі списку
  void _deleteCar(int index) {
    final deleted = _cars[index];
    setState(() {
      _cars.removeAt(index);
    });
    _saveData();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Видалено: ${deleted.title} (оновлено JSON)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // 9. Додавання нового елемента
  void _showAddCarDialog() {
    final titleController = TextEditingController();
    String selectedStatus = _availableStatuses.first;
    bool isFav = false;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Додати авто (JSON)'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Назва авто',
                        hintText: 'напр. Porsche Panamera 4S',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Статус',
                        border: OutlineInputBorder(),
                      ),
                      items: _availableStatuses.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedStatus = val);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('В обране ⭐'),
                      value: isFav,
                      onChanged: (val) {
                        setDialogState(() => isFav = val ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Скасувати'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      final newId = _cars.isEmpty
                          ? 1
                          : (_cars.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1);

                      final newCar = CarModel(
                        id: newId,
                        title: title,
                        isFavorite: isFav,
                        status: selectedStatus,
                      );

                      setState(() {
                        _cars.add(newCar);
                      });
                      _saveData();
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text('Зберегти в JSON'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 10. Редагування існуючого елемента
  void _showEditCarDialog(int index) {
    final car = _cars[index];
    final titleController = TextEditingController(text: car.title);
    String selectedStatus = _availableStatuses.contains(car.status)
        ? car.status
        : _availableStatuses.first;
    bool isFav = car.isFavorite;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Редагувати авто'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Назва авто',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Статус',
                        border: OutlineInputBorder(),
                      ),
                      items: _availableStatuses.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedStatus = val);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('В обране ⭐'),
                      value: isFav,
                      onChanged: (val) {
                        setDialogState(() => isFav = val ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Скасувати'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      setState(() {
                        _cars[index].title = title;
                        _cars[index].status = selectedStatus;
                        _cars[index].isFavorite = isFav;
                      });
                      _saveData();
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text('Оновити'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'В наявності':
        return Colors.green;
      case 'Заброньовано':
        return Colors.orange;
      case 'Продано':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Пошук авто (JSON сховище)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Скинути до початкового JSON',
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              final cars = await _storageService.resetToAssets();
              if (!mounted) return;
              setState(() => _cars = cars);
              messenger.showSnackBar(
                const SnackBar(content: Text('Дані скинуто до assets/cars.json')),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Інформаційна плашка про роботу з JSON
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.data_object, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Завантажено з JSON: ${_cars.length} авто (fromJson / toJson)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 8. Відображення даних за допомогою ListView.builder та ListTile
                Expanded(
                  child: _cars.isEmpty
                      ? const Center(child: Text('Список порожній'))
                      : ListView.builder(
                          itemCount: _cars.length,
                          itemBuilder: (context, index) {
                            final car = _cars[index];
                            final statusColor = _getStatusColor(car.status);

                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                // Іконка авто з кольором статусу
                                leading: CircleAvatar(
                                  backgroundColor: statusColor.withValues(alpha: 0.15),
                                  child: Icon(Icons.directions_car, color: statusColor),
                                ),
                                // Назва елемента
                                title: Text(
                                  car.title,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                ),
                                // Статус авто з можливістю відкрити редагування
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                                      ),
                                      child: Text(
                                        car.status,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // 10. Натискання для редагування
                                onTap: () => _showEditCarDialog(index),
                                // Дії: Обране (isFavorite), Редагування, Видалення
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // 12. Перемикання стану isFavorite ⭐
                                    IconButton(
                                      icon: Icon(
                                        car.isFavorite ? Icons.star : Icons.star_border,
                                        color: car.isFavorite ? Colors.amber : Colors.grey,
                                        size: 24,
                                      ),
                                      onPressed: () => _toggleFavorite(index),
                                      tooltip: 'В обране',
                                    ),
                                    // 10. Кнопка редагування ✏️
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 22),
                                      onPressed: () => _showEditCarDialog(index),
                                      tooltip: 'Редагувати',
                                    ),
                                    // 11. Видалення 🗑️
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                                      onPressed: () => _deleteCar(index),
                                      tooltip: 'Видалити',
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
      // 9. Додавання нового елемента до списку
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCarDialog,
        icon: const Icon(Icons.add),
        label: const Text('Додати авто (JSON)'),
      ),
    );
  }
}
