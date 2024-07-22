import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Home/views/widgets/benefeciary_card.dart';
import 'package:pay_me/Modules/Transaction/bloc/cubit/transaction_cubit.dart';
import 'package:pay_me/Modules/Transaction/repository/transaction_repository.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

class TopUpPage extends StatefulWidget {
  final BeneficiaryModel beneficiary;
  final UserModel? user;

  const TopUpPage({super.key, required this.beneficiary, required this.user});

  @override
  TopUpPageState createState() => TopUpPageState();
}

class TopUpPageState extends State<TopUpPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> rechargeAmounts = [5, 10, 20, 30, 50, 75, 100];

    return BlocProvider(
        create: (context) => TransactionCubit(
              const UserRepository(),
              BeneficiaryRepository(),
              TransactionRepository(),
            ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              shadowColor: Colors.black,
              automaticallyImplyLeading: true,
              title: const Text('Top up',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: AppColors.white)),
              centerTitle: false,
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.beneficiary.name ?? '',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Select Recharge Amount:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 3,
                            ),
                            itemCount: rechargeAmounts.length,
                            itemBuilder: (context, index) {
                              return BlocBuilder<TransactionCubit,
                                  TransactionState>(builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<TransactionCubit>()
                                        .updateSelectedAmount(
                                            rechargeAmounts[index]);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: rechargeAmounts[index] ==
                                            state.selectedAmount
                                        ? AppColors.primary
                                        : AppColors.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  child: Text(
                                    'AED ${rechargeAmounts[index]}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                );
                              });
                            }),
                      ),
                      BlocBuilder<TransactionCubit, TransactionState>(
                          builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: SubmitButton(
                              isDisabled: state.selectedAmount == 0.0,
                              text: 'Send',
                              fontsize: 18,
                              height: 45,
                              onTap: () async {
                                if (state.selectedAmount != null ||
                                    state.isLoading == true) {
                                  if (widget.user!.balance <
                                      (state.selectedAmount! + 1)) {
                                    showAlert(
                                        context,
                                        "Error",
                                        state.error ??
                                            "Insufficient balance in your account",
                                        false);
                                    return;
                                  }
                                  var result = await context
                                      .read<TransactionCubit>()
                                      .topUp(widget.beneficiary, widget.user!);
                                  if (result == true && mounted) {
                                    // ignore: use_build_context_synchronously
                                    showAlert(context, "Successful",
                                        "Payment was successful", true);
                                  }
                                }
                              }),
                        );
                      })
                    ]))));
  }

  Future<dynamic> showAlert(
      BuildContext context, String title, String message, bool isSuccess) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(isSuccess ? Icons.check_circle : Icons.error,
                    color: isSuccess ? Colors.green : Colors.red),
                const SizedBox(width: 10),
                Text(title),
              ],
            ),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (isSuccess) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }
}
