class TransactionModel {
  final String? id;
  final String? beneficiaryId;
  final String? beneficiaryName;
  final String? userId;
  final DateTime? createdAt;
  final double amount;

  TransactionModel(
      {this.id,
      required this.beneficiaryId,
      this.beneficiaryName,
      this.userId,
      this.createdAt,
      this.amount = 0.0});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      beneficiaryId: json['beneficiary_id'] ?? '',
      userId: json['user_id'] ?? '',
      beneficiaryName: json['beneficiary_name'] ?? '',
      createdAt: json['created_at'] != null
          ? json['created_at'].toDate()
          : DateTime.now(),
      amount: json['amount'] ?? 0.0,
    );
  }
  static Map<String, dynamic> toJson(TransactionModel transaction) {
    return {
      'id': transaction.id,
      'beneficiary_id': transaction.beneficiaryId,
      'user_id': transaction.userId,
      'created_at': transaction.createdAt,
      'amount': transaction.amount,
      'beneficiary_name': transaction.beneficiaryName
    };
  }
}
