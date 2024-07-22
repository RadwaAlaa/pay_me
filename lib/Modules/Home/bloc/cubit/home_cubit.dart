import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;
  final BeneficiaryRepository beneficiaryRepository;

  HomeCubit(this.userRepository, this.beneficiaryRepository)
      : super(const HomeState()) {
    getUser();
  }
  Future<List<BeneficiaryModel>> getUserBeneficiaries(String userID) async {
    emit(state.copyWith(isLoadingBeneficiaries: true));

    var beneficiaries =
        await beneficiaryRepository.getUserBeneficiaries(userID);

    emit(state.copyWith(
      beneficiaryList: beneficiaries,
      isLoadingBeneficiaries: false,
      selectedView: ToggleView.recharge,
    ));
    return beneficiaries;
  }

  getUser() async {
    try {
      emit(const HomeState(isLoading: true));
      userRepository.getUser().then((user) async {
        emit(state.copyWith(
          user: user,
          isLoading: false,
        ));
        getUserBeneficiaries(user.id!);
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  addBeneficiary(BeneficiaryModel beneficiary) async {
    // call post api to create this beneficiary to the user.
    beneficiary.userId = state.user!.id;
    beneficiaryRepository.addBeneficiary(beneficiary);
    getUserBeneficiaries(state.user!.id!);
  }

  void getRechargeHistory() {
    emit(state.copyWith(selectedView: ToggleView.history));
    return null;
  }
}
