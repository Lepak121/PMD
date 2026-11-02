/// Перелік статусів автомобіля (enum згідно з вимогами)
enum CarStatus {
  available, // В наявності
  reserved,  // Заброньовано
  sold,      // Продано
}

extension CarStatusExtension on CarStatus {
  String get label {
    switch (this) {
      case CarStatus.available:
        return 'В наявності';
      case CarStatus.reserved:
        return 'Заброньовано';
      case CarStatus.sold:
        return 'Продано';
    }
  }
}

/// Клас моделі даних з 4 обов'язковими типами полів:
/// - int (id)
/// - String (title)
/// - bool (isFavorite)
/// - enum (status)
class CarModel {
  final int id;
  String title;
  bool isFavorite;
  CarStatus status;

  CarModel({
    required this.id,
    required this.title,
    required this.isFavorite,
    required this.status,
  });

  CarModel copyWith({
    int? id,
    String? title,
    bool? isFavorite,
    CarStatus? status,
  }) {
    return CarModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }
}
