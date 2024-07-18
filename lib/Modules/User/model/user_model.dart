class BeneficiaryModel {
  final String? id;
  final String? name;
  final bool? isVerified;
  final List<BeneficiaryModel>? beneficiaryList;

  BeneficiaryModel(
      {required this.id,
      required this.name,
      this.isVerified,
      this.beneficiaryList});

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        isVerified: json['is_verified'] ?? false,
        beneficiaryList: json['beneficiaries'] != null
            ? (json['beneficiaries'] as List<dynamic>?)
                ?.map(
                    (e) => BeneficiaryModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
      );
}
