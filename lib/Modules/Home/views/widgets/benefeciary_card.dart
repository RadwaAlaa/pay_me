import 'package:flutter/material.dart';
import 'package:pay_me/Core/app_colors.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';

class BenefeciaryCard extends StatelessWidget {
  final BeneficiaryModel beneficiary;
  final Function onTap;
  const BenefeciaryCard({
    required this.beneficiary,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        margin: const EdgeInsets.only(right: 10),
        width: 160,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.2), // Light grey shadow with opacity
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // Shadow position
            ),
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            beneficiary.name!,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff1F3A93),
                fontSize: 18),
          ),
          Text(
            beneficiary.mobile!,
            style: const TextStyle(
                fontWeight: FontWeight.w300,
                color: Color(0xff333333),
                fontSize: 16),
          ),
          SubmitButton(
            text: 'Recharge now',
            height: 25,
            fontsize: 13,
            onTap: () {
              onTap();
            },
          )
        ]));
  }
}

class SubmitButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double? height;
  final double? width;
  final double? fontsize;
  final bool? isDisabled;

  const SubmitButton({
    required this.text,
    required this.onTap,
    this.height,
    this.width,
    this.fontsize,
    this.isDisabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          top: 10,
        ),
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: isDisabled == true ? AppColors.grey : AppColors.primary,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontsize ?? 12.0,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
