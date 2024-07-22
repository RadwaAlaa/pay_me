import 'package:flutter/material.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';

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
