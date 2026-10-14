import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/features/hello/presentation/view/widgets/hello_btns_section.dart';
import 'package:shopping_app/features/hello/presentation/view/widgets/welcome_and_hello_image_section.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.x2),
          child: Column(
            children: [WelcomeAndHelloImageSection(), HelloBtnsSection()],
          ),
        ),
      ),
    );
  }
}
