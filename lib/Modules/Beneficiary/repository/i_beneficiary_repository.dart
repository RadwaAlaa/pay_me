import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';

abstract class IBeneficiaryRepository {
  Future<List<BeneficiaryModel>> getUserBeneficiaries(String userId);
  Future<void> addBeneficiary(BeneficiaryModel beneficiary);
}
