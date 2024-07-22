import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';

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
