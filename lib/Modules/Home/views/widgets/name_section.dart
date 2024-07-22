import 'package:flutter/material.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';

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
