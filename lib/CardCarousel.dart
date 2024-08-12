import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/utils.dart';

typedef OnAnimationComplete = VoidCallback;
class CardCarousel extends StatefulWidget {
  final List<Widget> cards;
  final int itemCount;
  ValueChanged<int> currentCardCallback;
  VoidCallback onClick;
  OnAnimationComplete onAnimationComplete;
  bool isReverse;
  CardCarousel(
      {required this.cards,
        required this.itemCount,
        required this.currentCardCallback,
        required this.onClick,
        required this.onAnimationComplete,
        this.isReverse = false,
        super.key});

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel>
    with TickerProviderStateMixin {
  int currentCard = 0;
  bool isItemClicked = false;
  double _currentCardOpacity = 1;
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.4,
  );
  late AnimationController _translateAnimationController;
  late Animation<double> _horizontalOffsetAnimation;


  @override
  void initState() {
    super.initState();
    currentCard = widget.itemCount * 10000;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(currentCard);
    });

    _translateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _horizontalOffsetAnimation = Tween<double>(
      begin: Get.width / 3,
      end: Get.width,
    ).animate(_translateAnimationController);


    _translateAnimationController.addListener(() {
      setState(() {});
    });

    _translateAnimationController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          _currentCardOpacity = 0;
          widget.onAnimationComplete();
        }
      });

    });

  }

  @override
  void dispose() {
    _pageController.dispose();
    _translateAnimationController.dispose();
    super.dispose();
  }

  void _onCardTap() {
    setState(() {
      isItemClicked = true;
      if (isItemClicked) {
        _translateAnimationController.forward(from: 0);
      }
      widget.onClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isReverse && isItemClicked){
      _currentCardOpacity = 1;
      _translateAnimationController.reverse();
      setState(() {
        isItemClicked = false;
      });

    }
    return PageView.builder(
      itemCount: null,
      physics: isItemClicked ? const NeverScrollableScrollPhysics() : null,
      onPageChanged: (index) {
        setState(() {
          currentCard = getRealIndex(index, 0, widget.itemCount);
          widget.currentCardCallback(currentCard);
        });
      },
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemBuilder: (context, index) {
        int currentIndex = getRealIndex(index, 0, widget.itemCount);
        Widget child = widget.cards[currentIndex];

        return GestureDetector(
          onTap: isItemClicked ? null : _onCardTap,
          child: AnimatedBuilder(
            animation: Listenable.merge([_pageController,_translateAnimationController]),
            child: child,
            builder: (context, child) {
              double pageOffset = (_pageController.page ?? 0) - index;
              double scale = 1.0 - (pageOffset.abs() * 0.3);
              double verticalOffset = pageOffset * 120;
              double rotate = pageOffset * 0.1;

              double opacity = currentCard == currentIndex
                  ? _currentCardOpacity
                  : 1.0;

              return Opacity(
                opacity: opacity,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(
                      currentCard == currentIndex
                          ? Get.width / 3
                          : _horizontalOffsetAnimation.value,
                      verticalOffset,
                    )
                    ..scale(scale)
                    ..rotateZ(rotate),
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
