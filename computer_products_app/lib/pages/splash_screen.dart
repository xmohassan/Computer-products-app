import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:computer_products_app/pages/login.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: Center(
              heightFactor: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("Lottie/Animation1.json"),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: bTNBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      nextScreen: const Login(),
      splashIconSize: 400,
      backgroundColor: bluee,
      duration: 10000,
    );
  }
}
