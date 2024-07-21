class BeneficiaryModel {
  final String? id;
  final String? name;
  final String? mobile;
  String? userId;

  BeneficiaryModel({
    required this.id,
    required this.name,
    this.userId,
    this.mobile,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        id: json['id'] ?? '',
        userId: json['user_id'] ?? '',
        name: json['name'] ?? '',
        mobile: json['mobile'] ?? '',
      );

  static Map<String, dynamic> toJson(BeneficiaryModel beneficiary) => {
        'id': beneficiary.id,
        'name': beneficiary.name,
        'mobile': beneficiary.mobile,
        'user_id': beneficiary.userId,
      };
}
