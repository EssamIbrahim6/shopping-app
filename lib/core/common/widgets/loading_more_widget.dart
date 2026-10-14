import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/extensions/context_extension.dart';

class LoadingMoreWidget extends StatelessWidget {
  const LoadingMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.x2),
      child: Center(child: Lottie.asset(AppAssets.loadingLottie, height: context.height * 0.15)),
    );
  }
}
