class BeneficiaryModel {
  final String? id;
  final String? name;
  final String? mobile;
  final double? credit;
  String? userId;

  BeneficiaryModel({
    required this.id,
    required this.name,
    required this.credit,
    this.userId,
    this.mobile,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        id: json['id'] ?? '',
        userId: json['user_id'] ?? '',
        name: json['name'] ?? '',
        mobile: json['mobile'] ?? '',
        credit: json['credit'] != null ? json['credit'].toDouble() : 0.0,
      );

  static Map<String, dynamic> toJson(BeneficiaryModel beneficiary) => {
        'id': beneficiary.id,
        'name': beneficiary.name,
        'mobile': beneficiary.mobile,
        'user_id': beneficiary.userId,
        'credit': beneficiary.credit,
      };
}
