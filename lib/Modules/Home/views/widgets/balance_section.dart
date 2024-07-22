import 'package:flutter/material.dart';
import 'package:pay_me/Core/app_colors.dart';

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
