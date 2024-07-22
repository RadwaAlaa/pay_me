import 'package:pay_me/Core/firestore_service.dart';
import 'package:pay_me/Modules/Transaction/model/transaction_model.dart';
import 'package:pay_me/Modules/Transaction/repository/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  late FirestoreService? firestoreService;
  TransactionRepository() {
    firestoreService = FirestoreService();
  }

  @override
  Future<void> createTransaction(TransactionModel transaction) async {
    await firestoreService!
        .addDocument("transactions", TransactionModel.toJson(transaction));
  }

  @override
  Future<List<TransactionModel>> getUserTransactionsByBeneficiaryId(
      String beneficiaryId) async {
    var result = await firestoreService!.getCollection("transactions");

    List<TransactionModel> list = [];
    for (var doc in result.docs) {
      var model = TransactionModel.fromJson(doc);
      if (model.benefeciaryId == beneficiaryId) {
        list.add(TransactionModel.fromJson(doc));
      }
    }
    return list;
  }

  @override
  Future<List<TransactionModel>> getUserTransactionsByUserId(
      String userId) async {
    var result = await firestoreService!.getCollection("transactions");

    List<TransactionModel> list = [];
    for (var doc in result.docs) {
      var model = TransactionModel.fromJson(doc.data());
      if (model.userId == userId) {
        list.add(model);
      }
    }
    return list;
  }
}
