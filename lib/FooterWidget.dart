import 'package:flutter/material.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';
import 'package:sendgifts/Utilities/Constant.dart';

class FooterWidget extends StatelessWidget {
  final int itemCount;

  const FooterWidget({required this.itemCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, bottom: Constant.paddingBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$itemCount",
            style: const TextStyle(
              fontSize: 24,
              color: ColorTheme.description,
              fontFamily: "RalewayBold",
            ),
          ),
          const Text(
            "Popular Items",
            style: TextStyle(
              fontSize: 20,
              color: ColorTheme.description,
              fontFamily: "RalewayMedium",
            ),
          ),
        ],
      ),
    );
  }
}
