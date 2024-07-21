class UserModel {
  final String? id;
  final String? name;
  final bool? isVerified;

  UserModel({
    required this.id,
    required this.name,
    this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        isVerified: json['is_verified'] ?? false,
      );

  Map<String, dynamic> toJson(UserModel user) {
    return {
      'id': user.id,
      'name': user.name,
      'is_verified': user.isVerified,
    };
  }
}
