import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Beneficiary/repository/i_beneficiary_repository.dart';

class BeneficiaryRepository extends IBeneficiaryRepository {
  @override
  Future<void> addBeneficiary(BeneficiaryModel beneficiary) async {
    // call post api to create this beneficiary to the user.
    var db = FirebaseFirestore.instance;
    await db
        .collection("beneficiaries")
        .add(BeneficiaryModel.toJson(beneficiary));
  }

  @override
  Future<List<BeneficiaryModel>> getUserBeneficiaries(String userId) async {
    var db = FirebaseFirestore.instance;
    await db.collection("beneficiaries").get().then((event) {
      var docs = event.docs;
      var beneficiaries = docs
          .map((e) => BeneficiaryModel.fromJson(e.data()))
          .toList()
          .where((element) => element.userId == userId)
          .toList();
      return beneficiaries;
    });
    return [];
  }
}
