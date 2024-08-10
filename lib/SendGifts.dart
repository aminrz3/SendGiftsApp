import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/CardWidget.dart';
import 'package:sendgifts/HeaderWidget.dart';
import 'package:sendgifts/FooterWidget.dart';
import 'package:sendgifts/CardCarousel.dart';
import 'package:sendgifts/PagerWidget.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';

class SendGifts extends StatefulWidget {
  const SendGifts({super.key});

  @override
  State<SendGifts> createState() => _SendGiftsState();
}

class _SendGiftsState extends State<SendGifts> with TickerProviderStateMixin {
  int itemCount = 6;
  int currentCard = 0;
  bool isItemClicked = false;
  final itemHeight = Get.height * 0.4;
  late AnimationController _animationController;
  late Animation<Offset> _headerFooterOffsetAnimation;
  late Animation<Offset> _pagerOffsetAnimation;

  late AnimationController _centerAnimationController;
  late Animation<Offset> _centerOffsetAnimation;
  late Animation<double> _centerHeightAnimation;

  late Animation<BorderRadius?> _borderRadiusAnimation;

  final List<Widget> cards = [
    const CardWidget(
      cardColor: ColorTheme.blackCard,
      shadowColor: ColorTheme.blackCardShadow,
      cardTextColor: ColorTheme.cardText,
      cardNumberBoxColor: ColorTheme.cardNumberBox,
      cardImagePath: 'assets/images/blackCard.png',
      description: "Scrumptious choco\nmocha cupcakes\nPack of 6",
      titleLine1: 'Assorted',
      titleLine2: 'Mocha Cupcakes',
      quantity: 2,
      viewingText: '120+ viewing',
      boughtText: '50+ bought',
    ),
    const CardWidget(
      cardColor: ColorTheme.whiteCard,
      cardColorOpacity: 0.4,
      shadowColor: ColorTheme.whiteCardShadow,
      cardTextColor: ColorTheme.cardText3,
      cardNumberBoxColor: ColorTheme.cardNumberBox2,
      cardDetailBoxColor: ColorTheme.whiteCardBox,
      cardImagePath: 'assets/images/whiteCard.png',
      description: "Intricate glass\nchandelier\nPack of 1",
      descriptionColor: ColorTheme.cardText3,
      titleLine1: 'Glass',
      titleLine2: 'Chandelier',
      quantity: 3,
      viewingText: '120+ viewing',
      boughtText: '50+ bought',
    ),
    const CardWidget(
      cardColor: ColorTheme.orangeCard,
      shadowColor: ColorTheme.orangeCardShadow,
      cardTextColor: ColorTheme.cardText,
      cardNumberBoxColor: ColorTheme.cardNumberBox,
      cardImagePath: 'assets/images/orangeCard.png',
      description: "Fresh white & pink\nroses bouquet\nPack of 12",
      descriptionColor: ColorTheme.cardText,
      titleLine1: 'Bouquet',
      titleLine2: 'Mixed Roses',
      quantity: 1,
      viewingText: '120+ viewing',
      boughtText: '50+ bought',
    ),
    const CardWidget(
      cardColor: ColorTheme.blackCard,
      shadowColor: ColorTheme.blackCardShadow,
      cardTextColor: ColorTheme.cardText,
      cardNumberBoxColor: ColorTheme.cardNumberBox,
      cardImagePath: 'assets/images/blackCard.png',
      description: "Scrumptious choco\nmocha cupcakes\nPack of 6",
      titleLine1: 'Assorted',
      titleLine2: 'Mocha Cupcakes',
      quantity: 2,
      viewingText: '120+ viewing',
      boughtText: '50+ bought',
    ),
    const CardWidget(
      cardColor: ColorTheme.whiteCard,
      cardColorOpacity: 0.4,
      shadowColor: ColorTheme.whiteCardShadow,
      cardTextColor: ColorTheme.cardText3,
      cardNumberBoxColor: ColorTheme.cardNumberBox2,
      cardDetailBoxColor: ColorTheme.whiteCardBox,
      cardImagePath: 'assets/images/whiteCard.png',
      description: "Intricate glass\nchandelier\nPack of 1",
      descriptionColor: ColorTheme.cardText3,
      titleLine1: 'Glass',
      titleLine2: 'Chandelier',
      quantity: 3,
      viewingText: '120+ viewing',
      boughtText: '50+ bought',
    ),
    const CardWidget(
      cardColor: ColorTheme.orangeCard,
      shadowColor: ColorTheme.orangeCardShadow,
      cardTextColor: ColorTheme.cardText,
      cardNumberBoxColor: ColorTheme.cardNumberBox,
      cardImagePath: 'assets/images/orangeCard.png',
      description: "Fresh white & pink\nroses bouquet\nPack of 12",
      descriptionColor: ColorTheme.cardText,
      titleLine1: 'Bouquet',
      titleLine2: 'Mixed Roses',
      quantity: 1,
      viewingText: '120+ viewing',
      boughtText: '50+ bought',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _headerFooterOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _pagerOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-2.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _centerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _centerOffsetAnimation = Tween<Offset>(
      begin: Offset(Get.width / 3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _centerAnimationController,
      curve: Curves.easeInOut,
    ));

    _centerHeightAnimation = Tween<double>(
      begin: itemHeight,
      end: Get.height,
    ).animate(CurvedAnimation(
      parent: _centerAnimationController,
      curve: Curves.easeInOut,
    ));

    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(36),
      end: BorderRadius.circular(0),
    ).animate(CurvedAnimation(
      parent: _centerAnimationController,
      curve: Curves.easeInOut,
    ));

  }

  @override
  void dispose() {
    _animationController.dispose();
    _centerAnimationController.dispose();
    super.dispose();
  }

  void _handleItemClick(bool clicked) {
    setState(() {
      isItemClicked = clicked;
      if (isItemClicked) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _centerAnimationController.reverse();
      }
    });
  }

  void _startCenterAnimation() {
    _centerAnimationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: _headerFooterOffsetAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const SizedBox(height: 80),
              SlideTransition(
                position: _pagerOffsetAnimation,
                child: Container(
                  margin: const EdgeInsets.only(left: 25),
                  width: 40,
                  child: PagerWidget(
                    numOfCards: itemCount,
                    currentCard: currentCard,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              FooterWidget(itemCount: itemCount),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _centerAnimationController,
          builder: (context, child) {
            final currentCardData = cards[currentCard] as CardWidget;
            return Center(
              child: Transform.translate(
                offset: _centerOffsetAnimation.value,
                child: SizedBox(
                  height: _centerHeightAnimation.value,
                  child: CardWidget(
                    cardColor: currentCardData.cardColor,
                    cardColorOpacity: currentCardData.cardColorOpacity,
                    shadowColor: currentCardData.shadowColor,
                    cardTextColor: currentCardData.cardTextColor,
                    cardNumberBoxColor: currentCardData.cardNumberBoxColor,
                    cardDetailBoxColor: currentCardData.cardDetailBoxColor,
                    cardImagePath: currentCardData.cardImagePath,
                    description: currentCardData.description,
                    descriptionColor: currentCardData.descriptionColor,
                    titleLine1: currentCardData.titleLine1,
                    titleLine2: currentCardData.titleLine2,
                    quantity: currentCardData.quantity,
                    viewingText: currentCardData.viewingText,
                    boughtText: currentCardData.boughtText,
                    borderRadius: _borderRadiusAnimation.value!,
                  ),
                ),
              ),
            );
          },
          child: cards[currentCard],
        ),
        CardCarousel(
          cards: cards,
          itemCount: itemCount,
          currentCardCallback: (currentCardCallback) {
            setState(() {
              currentCard = currentCardCallback;
            });
          },
          onClick: (bool isItemClicked) {
            _handleItemClick(isItemClicked);
          },
          onAnimationComplete: _startCenterAnimation,
        ),
      ],
    );
  }
}
