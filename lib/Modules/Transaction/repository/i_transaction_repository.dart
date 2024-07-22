import 'package:pay_me/Modules/Transaction/model/transaction_model.dart';

abstract class ITransactionRepository {
  Future<void> createTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getUserTransactionsByUserId(String userId);
  Future<List<TransactionModel>> getUserTransactionsByBeneficiaryId(
      String beneficiaryId);
}
