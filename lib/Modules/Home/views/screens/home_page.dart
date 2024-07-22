import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
import 'package:pay_me/Modules/Home/views/widgets/benefeciary_card.dart';
import 'package:pay_me/Modules/Home/views/widgets/beneficiary_form.dart';
import 'package:pay_me/Modules/Transaction/screens/top_up_page.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeCubit(const UserRepository(), BeneficiaryRepository()),
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                      if (state.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error ?? 'Error!'),
                          ),
                        );
                      }
                    }, builder: (context, state) {
                      var bloc = BlocProvider.of<HomeCubit>(context);
                      if (state.isLoading == true) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NameSection(user: state.user!),
                          BalanceSection(balance: state.user!.balance),
                          BeneficiariesSection(bloc: bloc),
                        ],
                      );
                    })
                  ]),
            )));
  }
}

class BeneficiariesSection extends StatelessWidget {
  const BeneficiariesSection({
    super.key,
    required this.bloc,
  });

  final HomeCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mobile Recharge: ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const ToggleButtonSection(),
        if (bloc.state.selectedView == ToggleView.history)
          HistorySection(bloc: bloc),
        if (bloc.state.selectedView == ToggleView.recharge)
          RechargeSection(bloc: bloc),
      ],
    );
  }
}

class HistorySection extends StatelessWidget {
  const HistorySection({
    super.key,
    required this.bloc,
  });

  final HomeCubit bloc;

  @override
  Widget build(BuildContext context) {
    return bloc.state.isLoadingHistory == true
        ? const Center(child: CircularProgressIndicator())
        : (bloc.state.transactionList == null ||
                bloc.state.transactionList!.isEmpty)
            ? const Center(
                child: Text('No transactions found'),
              )
            : SizedBox(
                height: 420,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: bloc.state.transactionList!.length,
                  itemBuilder: (context, index) {
                    var transaction = bloc.state.transactionList![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.beneficiaryName!,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${transaction.amount.toStringAsFixed(2)} AED',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          Text(
                            '${transaction.createdAt!.day}/${transaction.createdAt!.month}/${transaction.createdAt!.year}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
  }
}

class RechargeSection extends StatelessWidget {
  const RechargeSection({
    super.key,
    required this.bloc,
  });

  final HomeCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: bloc.state.isLoadingBeneficiaries == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                if (bloc.state.beneficiaryList == null ||
                    bloc.state.beneficiaryList!.isEmpty)
                  const Center(
                    child: Text('No beneficiaries found'),
                  ),
                if (bloc.state.beneficiaryList != null ||
                    bloc.state.beneficiaryList!.isNotEmpty)
                  SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.state.beneficiaryList!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            BenefeciaryCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopUpPage(
                                            user: bloc.state.user,
                                            beneficiary: bloc
                                                .state.beneficiaryList![index],
                                          )),
                                ).then((val) {
                                  bloc.getUser();
                                });
                              },
                              beneficiary: bloc.state.beneficiaryList![index],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                AddNewButton(bloc: bloc),
              ]));
  }
}

class AddNewButton extends StatelessWidget {
  const AddNewButton({
    super.key,
    required this.bloc,
  });

  final HomeCubit bloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (bloc.state.beneficiaryList != null &&
              bloc.state.beneficiaryList!.length >= 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You can not add more than 5 beneficiaries'),
              ),
            );
          } else {
            showModalBottomSheet(
              backgroundColor: AppColors.white,
              context: context,
              builder: (context) {
                return BenefeciaryForm(
                  onSubmit: (benefeciary) {
                    bloc.addBeneficiary(benefeciary);
                    Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                size: 40,
              ),
            ],
          ),
        ));
  }
}

class ToggleButtonSection extends StatelessWidget {
  const ToggleButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.lightGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ToggleButton(
                text: "Recharge",
                isSelected: state.selectedView == ToggleView.recharge,
                onTap: () {
                  context
                      .read<HomeCubit>()
                      .getUserBeneficiaries(state.user!.id!);
                },
              ),
              ToggleButton(
                text: "History",
                isSelected: state.selectedView == ToggleView.history,
                onTap: () {
                  context.read<HomeCubit>().getRechargeHistory();
                },
              ),
            ],
          ));
    });
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onTap;
  const ToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: (MediaQuery.of(context).size.width - 48) * 0.5,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: isSelected == true ? AppColors.white : Colors.transparent,
        ),
        child: ToggleText(
          text: text,
          isSelected: isSelected,
        ),
      ),
    );
  }
}

class ToggleText extends StatelessWidget {
  final String text;
  final bool isSelected;
  const ToggleText({
    required this.text,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: isSelected == true ? AppColors.primary : AppColors.darkGrey,
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ));
  }
}

class BalanceSection extends StatelessWidget {
  final double? balance;

  const BalanceSection({
    this.balance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Balance',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.darkGrey)),
          Text('${balance ?? 0.0} AED',
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.darkGrey)),
        ],
      ),
    );
  }
}

class NameSection extends StatelessWidget {
  final UserModel user;
  const NameSection({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${user.name}",
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: AppColors.primary)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user.isVerified == true ? "Verified" : "Not Verified",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.secondary)),
              Icon(
                Icons.verified,
                color: user.isVerified == true
                    ? AppColors.secondary
                    : AppColors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
