import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Modules/Beneficiary/views/beneficiary_model.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Pay Me'),
          centerTitle: true,
        ),
        body: BlocProvider(
            create: (context) => HomeCubit(UserRepository()),
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocConsumer<HomeCubit, HomeState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state.isLoading == true) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state.user != null) {
                              return Column(
                                children: [
                                  Text(
                                    'Hello, ${state.user!.name!}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Your Beneficiaries',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  if (state.user!.beneficiaryList != null &&
                                      state.user!.beneficiaryList!.isNotEmpty)
                                    SizedBox(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            state.user!.beneficiaryList!.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              BenefeciaryCard(
                                                beneficiary: state.user!
                                                    .beneficiaryList![index],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: Text('No beneficiaries found'),
                              );
                            }
                          })
                    ]))));
  }
}

class BenefeciaryCard extends StatelessWidget {
  final BeneficiaryModel beneficiary;
  const BenefeciaryCard({
    required this.beneficiary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        margin: const EdgeInsets.only(right: 10),
        width: 154,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(children: [
          Text(
            beneficiary.name!,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.blue, fontSize: 18),
          ),
          Text(
            beneficiary.mobile!,
            style: const TextStyle(
                fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 18),
          ),
        ]));
  }
}
