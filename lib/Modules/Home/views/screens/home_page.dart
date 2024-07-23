import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
import 'package:pay_me/Modules/Home/views/widgets/balance_section.dart';
import 'package:pay_me/Modules/Home/views/widgets/history_section.dart';
import 'package:pay_me/Modules/Home/views/widgets/name_section.dart';
import 'package:pay_me/Modules/Home/views/widgets/recharge_section.dart';
import 'package:pay_me/Modules/Home/views/widgets/toggle_section.dart';

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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
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
        ));
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
