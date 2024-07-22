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
      await transactionRepository.createTransaction(TransactionModel(
          amount: state.selectedAmount!,
          benefeciaryId: beneficiary.id,
          userId: user.id,
          createdAt: DateTime.now(),
          id: DateTime.now().toString()));

      userRepository.updateBalance(state.selectedAmount!, user);
      emit(state.copyWith(isLoading: false, isTransactionSuccess: true));
      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false, isTransactionSuccess: false));
      return false;
    }
    return false;
  }
}
