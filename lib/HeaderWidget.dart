import 'package:flutter/material.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';
import 'package:sendgifts/Utilities/Constant.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Constant.paddingTop, left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ColorTheme.arrowBackBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/arrow_left.png',
              scale: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Send",
            style: TextStyle(
              color: ColorTheme.text,
              fontFamily: 'RalewayMedium',
              fontSize: 40,
            ),
          ),
          const Text(
            "GIFTS",
            style: TextStyle(
              color: ColorTheme.text,
              fontFamily: 'RalewayBold',
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
