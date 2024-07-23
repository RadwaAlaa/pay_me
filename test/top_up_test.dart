import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Transaction/bloc/cubit/transaction_cubit.dart';
import 'package:pay_me/Modules/Transaction/repository/transaction_repository.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('top up Cubit', () {
    test('test top up beneficiary', () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      var userRepo = const UserRepository();

      var cubit = TransactionCubit(
          userRepo, BeneficiaryRepository(), TransactionRepository());

      var user =
          //await userRepo.getUser('qHoLIXadBmhoYiEvn3RAeaE2SAG3');
          UserModel(
        id: "qHoLIXadBmhoYiEvn3RAeaE2SAG3",
        name: "John Doe",
        email: "jd@gmail.com",
        balance: 1000.0,
      );
      double oldBalance = user.balance;

      BeneficiaryModel beneficiary = BeneficiaryModel(
          id: "1",
          name: "Jane Harrison",
          credit: 0.0,
          userId: user.id,
          mobile: "+9715353769");
      double credit = 50.0;

      cubit.updateSelectedAmount(credit);

      var result = await cubit.topUp(
        beneficiary,
        user,
      );
      if (result == true) {
        userRepo.getUser(user.id!).then((value) {
          expect(value.balance, oldBalance - credit - 1);
        });
      }
      expect(result, true);
    });
  });
}
