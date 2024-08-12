import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';
import 'package:sendgifts/Utilities/Constant.dart';

class CardPage extends StatefulWidget {
  final Color cardColor;
  final Color cardTextColor;
  final Color cardDetailBoxColor;
  final String cardImagePath;
  final Color descriptionColor;
  final String secondPageText;
  final Color buyButtonColor;
  final String secondPageTitleLine1;
  final String secondPageTitleLine2;

  const CardPage({
    super.key,
    required this.cardColor,
    required this.cardTextColor,
    required this.cardDetailBoxColor,
    required this.cardImagePath,
    required this.descriptionColor,
    required this.secondPageText,
    required this.buyButtonColor,
    required this.secondPageTitleLine1,
    required this.secondPageTitleLine2,
  });

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    final bool isWhiteCard = widget.cardColor == ColorTheme.whiteCard;
    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: Constant.paddingTop, left: 40, right: 25),
                      child: Image.asset(widget.cardImagePath,width: Get.width,)),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.translate(
                      offset: const Offset(30, 40.0),
                      child: Transform.rotate(
                        angle:-1/9,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40)
                            ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width: Get.width / 1.4,
                              height: 144,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)
                                )
                              ),
                              padding: EdgeInsets.only(top: 20,left: 25),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.secondPageTitleLine1,
                                    style: TextStyle(
                                      color: widget.cardTextColor,
                                      fontFamily: 'RalewayRegular',
                                      fontSize: 36
                                    ),
                                  ),
                                  Text(
                                    widget.secondPageTitleLine2,
                                    style: TextStyle(
                                        color: widget.cardTextColor,
                                        fontFamily: 'RalewaySemiBold',
                                        fontSize: 36
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 25,top: 85),
                child: Text(
                  widget.secondPageText,
                  style: TextStyle(
                      color: widget.descriptionColor,
                      fontSize: 16,
                      fontFamily: 'RalewayRegular'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 25,top: 50),
              child: Transform.rotate(
                angle: 0.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: Get.width,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isWhiteCard
                            ? widget.cardDetailBoxColor.withOpacity(0.05)
                            : widget.cardDetailBoxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "\$599",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: widget.cardTextColor,
                                      fontFamily: 'RalewaySemiBold'
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "inclusive of all taxes",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: widget.cardTextColor,
                                      fontFamily: 'RalewayRegular'
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 92,
                            height: 70,
                            decoration: BoxDecoration(
                              color: widget.buyButtonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Image.asset('assets/images/buy.png',scale: 1.5,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
