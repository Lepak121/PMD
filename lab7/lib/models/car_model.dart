/// Модель даних для автомобіля з методами серіалізації/десеріалізації JSON
class CarModel {
  final int id;
  String title;
  bool isFavorite;
  String status;

  CarModel({
    required this.id,
    required this.title,
    required this.isFavorite,
    required this.status,
  });

  /// 6. Фабричний конструктор fromJson() для створення об'єкта з JSON Map
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as int,
      title: json['title'] as String,
      isFavorite: json['isFavorite'] as bool,
      status: json['status'] as String,
    );
  }

  /// 6. Метод toJson() для перетворення об'єкта в JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isFavorite': isFavorite,
      'status': status,
    };
  }

  CarModel copyWith({
    int? id,
    String? title,
    bool? isFavorite,
    String? status,
  }) {
    return CarModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }
}

