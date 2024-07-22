import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              backgroundColor: const Color(0xff1F3A93),
              shadowColor: Colors.black,
              automaticallyImplyLeading: true,
              title: const Text('Top up',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xffFFD700))),
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
                                        ? const Color(0xff1F3A93)
                                        : const Color(0xff3A7BD5),
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
                                  var result = await context
                                      .read<TransactionCubit>()
                                      .topUp(widget.beneficiary, widget.user!);
                                  if (result == true && mounted) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  }
                                }
                              }),
                        );
                      })
                    ]))));
  }
}
