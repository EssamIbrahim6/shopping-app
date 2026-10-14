import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/common/widgets/error_info.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    AppAssets.error404Illustration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Lost in Space!",
                description:
                    "The page you are looking for seems to be missing. Please go back or visit the homepage.",
                btnText: "Back to home",
                press: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.appSection,
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
