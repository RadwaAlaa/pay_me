class BeneficiaryModel {
  final String? id;
  final String? name;
  final String? mobile;

  BeneficiaryModel({
    required this.id,
    required this.name,
    this.mobile,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        mobile: json['mobile'] ?? '',
      );
}
