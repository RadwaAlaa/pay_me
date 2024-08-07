import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Transaction/model/transaction_model.dart';
import 'package:pay_me/Modules/Transaction/repository/transaction_repository.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final UserRepository userRepository;
  final BeneficiaryRepository beneficiaryRepository;
  final TransactionRepository transactionRepository;

  TransactionCubit(this.userRepository, this.beneficiaryRepository,
      this.transactionRepository)
      : super(const TransactionState());

  void updateSelectedAmount(double rechargeAmount) {
    emit(state.copyWith(selectedAmount: rechargeAmount));
  }

  Future<bool> topUp(BeneficiaryModel beneficiary, UserModel user) async {
    try {
      emit(state.copyWith(isLoading: true));

      var allTransactions =
          await transactionRepository.getUserTransactionsByUserId(user.id!);
      if (checkLimit(allTransactions, beneficiary, user.isVerified ?? false) ==
          true) {
        await userRepository.updateBalance(state.selectedAmount ?? 0, user);
        await transactionRepository.createTransaction(TransactionModel(
            amount: state.selectedAmount!,
            beneficiaryId: beneficiary.id,
            beneficiaryName: beneficiary.name,
            userId: user.id,
            createdAt: DateTime.now(),
            id: DateTime.now().toString()));

        emit(state.copyWith(isLoading: false, isTransactionSuccess: true));
        return true;
      } else {
        emit(state.copyWith(
            isLoading: false,
            isTransactionSuccess: false,
            error: 'Transaction limit exceeded'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isTransactionSuccess: false, error: e.toString()));
      return false;
    }
  }

  bool checkLimit(List<TransactionModel> list, BeneficiaryModel beneficiary,
      bool isUserVerified) {
    if (list.isEmpty) {
      return true;
    }
    var totalMonthlyTransactions = list
        .where((e) =>
            e.createdAt?.month == DateTime.now().month &&
            e.createdAt?.year == DateTime.now().year)
        .toList();
    if (totalMonthlyTransactions.isEmpty) {
      return true;
    }

    var totalMonthlyLimit = totalMonthlyTransactions
        .map((transaction) => transaction.amount)
        .toList()
        .reduce((a, b) => a + b);
    if (totalMonthlyLimit < 3000) {
      var beneficiarytransactions = totalMonthlyTransactions
          .where((e) => e.beneficiaryId == beneficiary.id)
          .toList();
      if (beneficiarytransactions.isEmpty) {
        return true;
      }

      if (isUserVerified) {
        if (beneficiarytransactions
                .map((element) => element.amount)
                .toList()
                .reduce((a, b) => a + b) <
            500) {
          return true;
        } else {
          return false;
        }
      } else {
        if (beneficiarytransactions
                .map((element) => element.amount)
                .toList()
                .reduce((a, b) => a + b) <
            1000) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }
}
