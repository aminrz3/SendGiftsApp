import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/CardItem.dart';
import 'package:sendgifts/CardPage.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';

class CardWidget extends StatefulWidget {
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
  final String secondPageText;
  final Color buyButtonColor;
  final String secondPageTitleLine1;
  final String secondPageTitleLine2;
  final bool isStartSecondPageAnimation;

  const CardWidget({
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
    required this.secondPageText,
    this.buyButtonColor=ColorTheme.blackCard,
    required this.secondPageTitleLine1,
    required this.secondPageTitleLine2,
    this.isStartSecondPageAnimation=false,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        color: widget.cardColor.withOpacity(widget.cardColorOpacity),
        borderRadius: widget.borderRadius,
      ),
      child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
            child: widget.isStartSecondPageAnimation ? CardPage(
                cardColor: widget.cardColor,
                cardTextColor: widget.cardTextColor,
                cardDetailBoxColor: widget.cardDetailBoxColor,
                cardImagePath: widget.cardImagePath,
                descriptionColor: widget.descriptionColor,
                secondPageText: widget.secondPageText,
                buyButtonColor: widget.buyButtonColor,
                secondPageTitleLine1: widget.secondPageTitleLine1,
                secondPageTitleLine2: widget.secondPageTitleLine2) :
            Carditem(
                cardColor: widget.cardColor,
                cardColorOpacity: widget.cardColorOpacity,
                cardDetailBoxColor: widget.cardDetailBoxColor,
                shadowColor: widget.shadowColor,
                cardTextColor: widget.cardTextColor,
                cardNumberBoxColor: widget.cardNumberBoxColor,
                cardImagePath: widget.cardImagePath,
                description: widget.description,
                titleLine1: widget.titleLine1,
                titleLine2: widget.titleLine2,
                quantity: widget.quantity,
                viewingText: widget.viewingText,
                boughtText: widget.boughtText
            ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          )
      ),
    );
  }
}
