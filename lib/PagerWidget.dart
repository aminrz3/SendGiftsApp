import 'package:flutter/material.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';

class PagerWidget extends StatefulWidget {
  int numOfCards;
  int currentCard;

  PagerWidget({super.key, required this.numOfCards, required this.currentCard});

  @override
  State<PagerWidget> createState() => _PagerWidgetState();
}

class _PagerWidgetState extends State<PagerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.numOfCards,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: index == widget.currentCard
                  ? Border.all(color: ColorTheme.pagerEnable, width: 1.5)
                  : null,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: index == widget.currentCard
                    ? ColorTheme.pagerEnable
                    : ColorTheme.pagerDisable,
                shape: BoxShape.circle,
              ),
              height: 8,
              width: 8,
            ),
          ),
        );
      },
    );
  }
}
