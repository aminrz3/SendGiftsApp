import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/CardData.dart';
import 'package:sendgifts/CardWidget.dart';
import 'package:sendgifts/HeaderWidget.dart';
import 'package:sendgifts/FooterWidget.dart';
import 'package:sendgifts/CardCarousel.dart';
import 'package:sendgifts/PagerWidget.dart';
import 'package:sendgifts/SlideGradientTransform.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';
import 'package:sendgifts/Utilities/Constant.dart';

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
  double _centerOpacity = 0;
  bool _isStartSecondPageAnimation = false;
  bool isReverseCardWidgetAnimation = false;

  late AnimationController _animationController;
  late Animation<Offset> _headerFooterOffsetAnimation;
  late Animation<Offset> _pagerOffsetAnimation;

  late AnimationController _centerAnimationController;
  late Animation<Offset> _centerOffsetAnimation;
  late Animation<double> _centerHeightAnimation;

  late Animation<BorderRadius?> _borderRadiusAnimation;

  late AnimationController _navbarAnimationController;
  late Animation<Offset> _navbarOffsetAnimation;

  late AnimationController _arrowAnimationController;
  final List<Widget> cards = CardData.cardItems;

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
    ))..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _centerOpacity = 0;
          isReverseCardWidgetAnimation = true;
        });

        Future.delayed(Duration(milliseconds: 250),(){
          setState(() {
            isReverseCardWidgetAnimation = false;
          });
        });
      }
    });

    _centerHeightAnimation = Tween<double>(
      begin: itemHeight,
      end: Get.height,
    ).animate(CurvedAnimation(
      parent: _centerAnimationController,
      curve: Curves.easeInOut,
    ))..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _navbarAnimationController.forward();
        setState(() {
          _isStartSecondPageAnimation = true;
        });
      }
    });

    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(36),
      end: BorderRadius.circular(0),
    ).animate(CurvedAnimation(
      parent: _centerAnimationController,
      curve: Curves.easeInOut,
    ));


    _navbarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _navbarOffsetAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: const Offset(-0.01, 0.0),
    ).animate(CurvedAnimation(
      parent: _navbarAnimationController,
      curve: Curves.easeInOut,
    ))..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _animationController.reverse();
        _centerAnimationController.reverse();
      }
    });

    _arrowAnimationController = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _centerAnimationController.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

  void _handleItemClick(bool clicked) {
    setState(() {
      isItemClicked = clicked;
      if (isItemClicked) {
        _centerOpacity = 1;
        _animationController.forward();
      } else {
        _navbarAnimationController.reverse();
        _arrowAnimationController.stop();
        _isStartSecondPageAnimation = false;
      }
    });
  }

  void _startCenterAnimation() {
    _arrowAnimationController.repeat(
        min: -0.5,
        max: 1.5,
        reverse: false,
        period: const Duration(seconds: 1)
    );
    _centerAnimationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    final currentCardData = cards[currentCard] as CardWidget;
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          color: ColorTheme.bg
      ),
      child: Stack(
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
              return Opacity(
                opacity: _centerOpacity,
                child: Center(
                  child: Transform.translate(
                    offset: _centerOffsetAnimation.value,
                    child: SizedBox(
                      height: _centerHeightAnimation.value,
                      child: CardWidget(
                        cardColor: currentCardData.cardColor,
                        cardColorOpacity: currentCardData.cardColorOpacity,
                        shadowColor: currentCardData.shadowColor,
                        isVisibleShadow: false,
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
                        secondPageText: currentCardData.secondPageText,
                        buyButtonColor: currentCardData.buyButtonColor,
                        secondPageTitleLine1: currentCardData.secondPageTitleLine1,
                        secondPageTitleLine2: currentCardData.secondPageTitleLine2,
                        isStartSecondPageAnimation: _isStartSecondPageAnimation,
                      ),
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
            onClick: () {

              _handleItemClick(true);
            },
            onAnimationComplete: _startCenterAnimation,
            isReverse: isReverseCardWidgetAnimation,
          ),
          SlideTransition(
            position: _navbarOffsetAnimation,
            child: Container(
              margin: EdgeInsets.only(top:Constant.paddingTop),
              child: Stack(
                children: [
                  Image.asset("assets/images/navbar.png",color: currentCardData.cardColor == ColorTheme.whiteCard ? ColorTheme.blackCard : ColorTheme.whiteCard),
                  Positioned(
                    width: 100,
                    height: 50,
                    bottom: 18,
                    left: 42,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        _handleItemClick(false);
                      },
                      child: AnimatedBuilder(
                          animation: _arrowAnimationController,
                          child: Row(
                            children: [
                              Image.asset('assets/images/arrow_right.png',scale: 1.8, color: currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white : Colors.black,),
                              const SizedBox(width: 5,),
                              Image.asset('assets/images/arrow_right.png',scale: 1.8, color: currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white : Colors.black,),
                              const SizedBox(width: 5,),
                              Image.asset('assets/images/arrow_right.png',scale: 1.8, color: currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white : Colors.black,),
                            ],
                          ),
                          builder: (context , child){

                            return ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                transform: SlideGradientTransform(
                                  percent: _arrowAnimationController.value,
                                ),
                                colors: [
                                  currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3),
                                  currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white : Colors.black,
                                  currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white : Colors.black,
                                  currentCardData.cardColor == ColorTheme.whiteCard ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3),
                                ],


                              ).createShader(bounds),
                              child: child,
                            );
                          }
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
