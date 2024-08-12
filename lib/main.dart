import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/SendGifts.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';
import 'package:sendgifts/Utilities/Constant.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'RalewayMedium',
          canvasColor: Colors.transparent
      ),

      home: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).viewPadding.top;
    var bottom = MediaQuery.of(context).viewPadding.bottom;
    print(top);
    print(bottom);
    Constant.paddingBottom = bottom+25;
    Constant.paddingTop = top+25;

    return Scaffold(
      body: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          color: ColorTheme.bg
        ),
        child: const SendGifts(),
      ),
    );
  }
}

