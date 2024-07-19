import 'package:pay_me/Modules/Beneficiary/views/beneficiary_model.dart';

class UserModel {
  final String? id;
  final String? name;
  final bool? isVerified;
  final List<BeneficiaryModel>? beneficiaryList;

  UserModel(
      {required this.id,
      required this.name,
      this.isVerified,
      this.beneficiaryList});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
