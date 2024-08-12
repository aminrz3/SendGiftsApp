import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';

class Carditem extends StatefulWidget {
  final Color cardColor;
  final BorderRadius borderRadius;
  final double cardColorOpacity;
  final Color shadowColor;
  final bool isVisibleShadow;
  final Color cardTextColor;
  final Color cardNumberBoxColor;
  final Color cardDetailBoxColor;
  final String cardImagePath;
  final String description;
  final Color descriptionColor;
  final String titleLine1;
  final String titleLine2;
  final int quantity;
  final String viewingText;
  final String boughtText;
  const Carditem({
    super.key,
    required this.cardColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(36)),
    this.cardColorOpacity = 1,
    required this.shadowColor,
    this.isVisibleShadow = true,
    required this.cardTextColor,
    required this.cardNumberBoxColor,
    this.cardDetailBoxColor = ColorTheme.cardNumberBox,
    required this.cardImagePath,
    required this.description,
    this.descriptionColor = ColorTheme.cardText2,
    required this.titleLine1,
    required this.titleLine2,
    required this.quantity,
    required this.viewingText,
    required this.boughtText,
  });

  @override
  State<Carditem> createState() => _CarditemState();
}

class _CarditemState extends State<Carditem> {
  @override
  Widget build(BuildContext context) {
    final bool isWhiteCard = widget.cardColor == ColorTheme.whiteCard;
    return Stack(
      children: [
        if (isWhiteCard)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: widget.cardColor.withOpacity(widget.cardColorOpacity),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(35),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: widget.isVisibleShadow ? 1 : 0,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: widget.shadowColor.withOpacity(0.5),
                          blurRadius: 100,
                          spreadRadius: 1,
                          offset: const Offset(0.0, 85),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Image.asset(
                              widget.cardImagePath,
                              width: 61,
                              height: 61,
                            ),
                          ),
                          Container(
                            width: 43,
                            height: 43,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                isWhiteCard ?
                                Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    color: widget.cardNumberBoxColor,
                                    shape: BoxShape.circle,
                                  ),
                                ) :
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(21.5),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                                    child: Container(
                                      width: 43,
                                      height: 43,
                                      decoration: BoxDecoration(
                                        color: widget.cardNumberBoxColor.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${widget.quantity}",
                                    style: TextStyle(
                                      color: widget.cardTextColor,
                                      fontFamily: 'RalewaySemiBold',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Text(
                        widget.description,
                        style: TextStyle(
                          color: widget.descriptionColor,
                          fontSize: 14,
                          fontFamily: "RalewayRegular",
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titleLine1,
                        style: TextStyle(
                          color: widget.cardTextColor,
                          fontFamily: 'RalewayRegular',
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        widget.titleLine2,
                        style: TextStyle(
                          color: widget.cardTextColor,
                          fontFamily: 'RalewaySemiBold',
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 65,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isWhiteCard ? widget.cardDetailBoxColor.withOpacity(0.05) : widget.cardDetailBoxColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/view.png',
                                      scale: 1.5,
                                      color: widget.cardTextColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      widget.viewingText,
                                      style: TextStyle(
                                        color: widget.cardTextColor,
                                        fontSize: 14,
                                        fontFamily: 'RalewayRegular',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/bag.png',
                                      scale: 1.5,
                                      color: widget.cardTextColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      widget.boughtText,
                                      style: TextStyle(
                                        color: widget.cardTextColor,
                                        fontSize: 14,
                                        fontFamily: 'RalewayRegular',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
