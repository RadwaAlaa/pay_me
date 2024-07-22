class TransactionModel {
  final String? id;
  final String? benefeciaryId;
  final String? userId;
  final DateTime? createdAt;
  final double amount;

  TransactionModel(
      {this.id,
      required this.benefeciaryId,
      this.userId,
      this.createdAt,
      this.amount = 0.0});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] ?? '',
        benefeciaryId: json['beneficiary_id'] ?? '',
        userId: json['user_id'] ?? '',
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
        amount: json['amount'] ?? 0.0,
      );

  static Map<String, dynamic> toJson(TransactionModel transaction) => {
        'id': transaction.id,
        'beneficiary_id': transaction.benefeciaryId,
        'user_id': transaction.userId,
        'created_at': transaction.createdAt,
        'amount': transaction.amount,
      };
}
