import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/extensions/context_extension.dart';

class StartSearchWidget extends StatelessWidget {
  const StartSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppAssets.searchLottie, height: context.height * 0.18),
          verticalSpace(AppSpacing.x1),
          Text(
            AppStrings.startTypingToSearchProducts,
            style: TextStyle(color: context.colors.onSurfaceVariant.withValues(alpha: 0.6)),
          ),
        ],
      ),
    );
  }
}
