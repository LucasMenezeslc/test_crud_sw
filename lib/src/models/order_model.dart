class OrderModel {
  final String id;
  final String description;
  final bool finished;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.description,
    required this.finished,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'],
    description: json['description'],
    finished: json['finished'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'finished': finished,
    'createdAt': createdAt.toIso8601String(),
  };
}
