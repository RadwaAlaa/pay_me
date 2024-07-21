import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> getUserBeneficiaries(String userID) async {
    await beneficiaryRepository
        .getUserBeneficiaries(userID)
        .then((beneficiaries) {
      emit(state.copyWith(
        beneficiaryList: beneficiaries,
        isLoading: false,
      ));
    });
  }

  getUser() async {
    try {
      emit(const HomeState(isLoading: true));
      // var db = FirebaseFirestore.instance;
      // await db.collection("users").get().then((event) {
      //   var user = UserModel.fromJson(event.docs.first.data());
      userRepository.getUser().then((user) {
        getUserBeneficiaries(user.id!);
        emit(state.copyWith(
          user: user,
          isLoading: false,
        ));
      });
      // var user = await userRepository.getUser();
      // emit(state.copyWith(
      //   user: user, isLoading: false,
      //   //beneficiaryList: user.beneficiaryList
      // ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  addBeneficiary(BeneficiaryModel beneficiary) async {
    // call post api to create this beneficiary to the user.
    beneficiary.userId = state.user!.id;
    var db = FirebaseFirestore.instance;
    await db
        .collection("beneficiaries")
        .add(BeneficiaryModel.toJson(beneficiary));

    List<BeneficiaryModel> beneficiaryList = state.beneficiaryList ?? [];
    beneficiaryList.add(beneficiary);
    emit(state.copyWith(beneficiaryList: []));
    emit(state.copyWith(beneficiaryList: beneficiaryList));
  }
}
