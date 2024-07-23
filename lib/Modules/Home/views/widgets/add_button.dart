import 'package:flutter/material.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
import 'package:pay_me/Modules/Home/views/widgets/beneficiary_form.dart';

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
              scrollControlDisabledMaxHeightRatio: 0.7,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                size: 40,
                color: AppColors.primary,
              ),
              Text('Add new',
                  style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ));
  }
}
