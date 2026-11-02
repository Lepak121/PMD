import 'package:flutter/material.dart';
import '../models/car_model.dart';

/// Лабораторна робота №6
/// Екран зі списком ListView.builder, операціями додавання, видалення,
/// зміною стану елемента (isFavorite, status) та картою статистики `Map<String, int>`.
class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  // 4. List<CarModel> — основне джерело даних (мінімум 5 початкових елементів)
  final List<CarModel> _cars = [
    CarModel(
      id: 1,
      title: 'Audi A6 2.0 TFSI Quattro',
      isFavorite: true,
      status: CarStatus.available,
    ),
    CarModel(
      id: 2,
      title: 'BMW 520d xDrive Sedan',
      isFavorite: false,
      status: CarStatus.available,
    ),
    CarModel(
      id: 3,
      title: 'Mercedes-Benz E220d AMG',
      isFavorite: true,
      status: CarStatus.reserved,
    ),
    CarModel(
      id: 4,
      title: 'Volkswagen Passat B8 R-Line',
      isFavorite: false,
      status: CarStatus.available,
    ),
    CarModel(
      id: 5,
      title: 'Toyota Camry 2.5 Hybrid',
      isFavorite: false,
      status: CarStatus.sold,
    ),
  ];

  int _nextId = 6;

  // 8. Map<String, int> для статистики
  Map<String, int> get _statistics {
    return {
      'total': _cars.length,
      'favorite': _cars.where((c) => c.isFavorite).length,
      'available': _cars.where((c) => c.status == CarStatus.available).length,
      'reserved': _cars.where((c) => c.status == CarStatus.reserved).length,
      'sold': _cars.where((c) => c.status == CarStatus.sold).length,
    };
  }

  // 7. Зміна стану: перемикання "обране" через setState
  void _toggleFavorite(int index) {
    setState(() {
      _cars[index].isFavorite = !_cars[index].isFavorite;
    });
  }

  // 7. Зміна стану: перемикання статусу (enum) по колу
  void _cycleStatus(int index) {
    setState(() {
      final current = _cars[index].status;
      switch (current) {
        case CarStatus.available:
          _cars[index].status = CarStatus.reserved;
          break;
        case CarStatus.reserved:
          _cars[index].status = CarStatus.sold;
          break;
        case CarStatus.sold:
          _cars[index].status = CarStatus.available;
          break;
      }
    });
  }

  // 6. Видалення елемента
  void _deleteCar(int index) {
    final removedCar = _cars[index];
    setState(() {
      _cars.removeAt(index);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Видалено: ${removedCar.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // 6. Додавання нового елемента
  void _showAddCarDialog() {
    final titleController = TextEditingController();
    CarStatus selectedStatus = CarStatus.available;
    bool isFav = false;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Додати автомобіль'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Марка та модель',
                        hintText: 'напр. Skoda Superb 2.0 TDI',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<CarStatus>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Статус',
                        border: OutlineInputBorder(),
                      ),
                      items: CarStatus.values.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status.label),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedStatus = val);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text('Додати в обране ⭐'),
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
                    final text = titleController.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        _cars.add(
                          CarModel(
                            id: _nextId++,
                            title: text,
                            isFavorite: isFav,
                            status: selectedStatus,
                          ),
                        );
                      });
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text('Додати'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(CarStatus status) {
    switch (status) {
      case CarStatus.available:
        return Colors.green;
      case CarStatus.reserved:
        return Colors.orange;
      case CarStatus.sold:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = _statistics;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Пошук авто (Каталог)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 8. Блок відображення статистики Map<String, int>
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: _buildStatItem('Всього', stats['total'] ?? 0, Icons.directions_car, Colors.blue)),
                Expanded(child: _buildStatItem('Обрані', stats['favorite'] ?? 0, Icons.favorite, Colors.amber)),
                Expanded(child: _buildStatItem('В наявності', stats['available'] ?? 0, Icons.check_circle, Colors.green)),
                Expanded(child: _buildStatItem('Бронь', stats['reserved'] ?? 0, Icons.access_time, Colors.orange)),
              ],
            ),
          ),

          // 5. ListView.builder з ListTile
          Expanded(
            child: _cars.isEmpty
                ? const Center(
                    child: Text('Список автомобілів порожній'),
                  )
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
                          // Іконка авто
                          leading: CircleAvatar(
                            backgroundColor: statusColor.withValues(alpha: 0.15),
                            child: Icon(Icons.directions_car, color: statusColor),
                          ),
                          // Назва авто
                          title: Text(
                            car.title,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          // Статус (enum) зі зміною при натисканні
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => _cycleStatus(index),
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                                    ),
                                    child: Text(
                                      car.status.label,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Дії: Обране (isFavorite) та Видалення
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 7. Зміна стану isFavorite ⭐
                              IconButton(
                                icon: Icon(
                                  car.isFavorite ? Icons.star : Icons.star_border,
                                  color: car.isFavorite ? Colors.amber : Colors.grey,
                                  size: 24,
                                ),
                                onPressed: () => _toggleFavorite(index),
                                tooltip: 'В обране',
                              ),
                              // 6. Видалення елемента 🗑️
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
      // 6. Кнопка додавання нового елемента
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCarDialog,
        icon: const Icon(Icons.add),
        label: const Text('Додати авто'),
      ),
    );
  }

  Widget _buildStatItem(String label, int value, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 2),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
