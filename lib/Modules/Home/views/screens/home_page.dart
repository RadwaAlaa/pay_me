import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
import 'package:pay_me/Modules/Home/views/widgets/benefeciary_card.dart';
import 'package:pay_me/Modules/Home/views/widgets/beneficiary_form.dart';
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
            appBar: AppBar(
              backgroundColor: const Color(0xff1F3A93),
              shadowColor: Colors.black,
              automaticallyImplyLeading: false,
              title:
                  BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                String title = "Welcome ";
                if (state.user != null && state.user!.name != null) {
                  title += state.user!.name!;
                }
                return Text(title,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xffFFD700)));
              }),
              centerTitle: false,
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Benefeciaries: ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                if (state.beneficiaryList != null &&
                                    state.beneficiaryList!.length >= 5) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'You can not add more than 5 beneficiaries'),
                                    ),
                                  );
                                } else {
                                  showBottomSheet(
                                    backgroundColor: Colors.white,
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
                              child: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (state.beneficiaryList != null &&
                        state.beneficiaryList!.isNotEmpty)
                      SizedBox(
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.beneficiaryList!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                BenefeciaryCard(
                                  onTap: () {},
                                  beneficiary: state.beneficiaryList![index],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    if (state.beneficiaryList == null ||
                        state.beneficiaryList!.isEmpty)
                      const Center(
                        child: Text('No beneficiaries found'),
                      )
                  ],
                );
              })
            ])));
  }
}
