import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendgifts/SendGifts.dart';
import 'package:sendgifts/Utilities/ColorTheme.dart';
import 'package:sendgifts/Utilities/Constant.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeConstants(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loader until width is initialized.
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'RalewayMedium',
                canvasColor: Colors.transparent,
            ),
            home: const Scaffold(
              body: SendGifts(),
            ),
          );
        }
      },
    );
  }

  Future<void> _initializeConstants(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var mediaQueryData = MediaQuery.of(context);
      Constant.width = mediaQueryData.size.width;
      Constant.height = mediaQueryData.size.height;
      Constant.paddingBottom = mediaQueryData.viewPadding.bottom + 25;
      Constant.paddingTop = mediaQueryData.viewPadding.top + 25;
    });
  }
}

