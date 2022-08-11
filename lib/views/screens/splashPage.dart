import 'package:flutter/material.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/views/screens/homePage.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    NavHelper.navigateWithReplacementToWidget(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    initSplash();
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(child: Lottie.asset('assets/animation/money.json')));
  }
}
