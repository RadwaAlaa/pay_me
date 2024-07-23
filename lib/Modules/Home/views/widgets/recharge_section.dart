import 'package:flutter/material.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
import 'package:pay_me/Modules/Home/views/widgets/add_button.dart';
import 'package:pay_me/Modules/Home/views/widgets/benefeciary_card.dart';
import 'package:pay_me/Modules/Transaction/screens/top_up_page.dart';

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
                if (bloc.state.beneficiaryList != null &&
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
