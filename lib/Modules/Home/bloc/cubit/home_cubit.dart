import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Transaction/model/transaction_model.dart';
import 'package:pay_me/Modules/Transaction/repository/transaction_repository.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;
  final BeneficiaryRepository beneficiaryRepository;
  final String userId;

  HomeCubit(this.userRepository, this.beneficiaryRepository, this.userId)
      : super(const HomeState()) {
    getUser();
  }
  Future<List<BeneficiaryModel>> getUserBeneficiaries(String userID) async {
    try {
      emit(state.copyWith(isLoadingBeneficiaries: true));

      var beneficiaries =
          await beneficiaryRepository.getUserBeneficiaries(userID);

      emit(state.copyWith(
        beneficiaryList: beneficiaries,
        isLoadingBeneficiaries: false,
        selectedView: ToggleView.recharge,
      ));
      return beneficiaries;
    } catch (e) {
      emit(state.copyWith(isLoadingBeneficiaries: false, error: e.toString()));
    }
    return [];
  }

  getUser() async {
    try {
      emit(const HomeState(isLoading: true));
      userRepository.getUser(userId).then((user) async {
        emit(state.copyWith(
          user: user,
          isLoading: false,
        ));
        getUserBeneficiaries(user.id!);
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  addBeneficiary(BeneficiaryModel beneficiary) async {
    // call post api to create this beneficiary to the user.
    try {
      beneficiary.userId = state.user!.id;
      beneficiaryRepository.addBeneficiary(beneficiary);
      getUserBeneficiaries(state.user!.id!);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void getRechargeHistory() async {
    var result = <TransactionModel>[];

    try {
      emit(state.copyWith(isLoadingBeneficiaries: true));
      var transactionRepo = TransactionRepository();
      result =
          await transactionRepo.getUserTransactionsByUserId(state.user!.id!);
      emit(state.copyWith(
          isLoadingBeneficiaries: false,
          selectedView: ToggleView.history,
          transactionList: result));
    } catch (e) {
      emit(state.copyWith(
          error: e.toString(),
          isLoadingBeneficiaries: false,
          selectedView: ToggleView.history,
          transactionList: []));
    }
  }
}
