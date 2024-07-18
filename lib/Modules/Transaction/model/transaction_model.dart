class TransactionModel {
  final String? id;
  final String? benefeciaryId;
  final String? userId;
  final DateTime? createdAt;
  final double amount;

  TransactionModel(
      {required this.id,
      required this.benefeciaryId,
      this.userId,
      this.createdAt,
      this.amount = 0.0});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] ?? '',
        benefeciaryId: json['benefeciary_id'] ?? '',
        userId: json['user_id'] ?? '',
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
        amount: json['amount'] ?? 0.0,
      );
}
