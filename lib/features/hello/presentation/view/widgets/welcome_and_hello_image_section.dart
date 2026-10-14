import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/constants/app_assets.dart';

class WelcomeAndHelloImageSection extends StatelessWidget {
  const WelcomeAndHelloImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(AppAssets.helloImage, fit: BoxFit.contain),
          ),
          Expanded(
            flex: 2,
            child: Lottie.asset(AppAssets.hiLottie, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
