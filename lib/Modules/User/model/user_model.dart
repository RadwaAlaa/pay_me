class UserModel {
  final String? id;
  final String? name;
  final bool? isVerified;
  String documentId;
  double balance = 0.0;
  final String? email;

  UserModel({
    required this.id,
    required this.name,
    this.isVerified,
    this.documentId = '',
    this.balance = 0.0,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        isVerified: json['is_verified'] ?? false,
        balance: json['balance'] != null ? json['balance'].toDouble() : 0.0,
        email: json['email'] ?? '',
      );

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'id': user.id,
      'name': user.name,
      'is_verified': user.isVerified,
      'balance': user.balance,
      'email': user.email,
    };
  }
}
