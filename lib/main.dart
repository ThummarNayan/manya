import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:demo_1_e/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen(
      splash: Image.asset("image/Manyatech.jpg",fit: BoxFit.fill),
      nextScreen: dashboard(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      backgroundColor: Color(0xffc9f7ff),
    ),
  ));
}
