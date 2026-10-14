import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/extensions/context_extension.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.error, this.onRetry});
  final String error;
  final void Function()? onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/error__.png",
              height: context.height * 0.15,
            ),
            verticalSpace(AppSpacing.x1),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colors.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
            verticalSpace(AppSpacing.x1),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: Text(
                  AppStrings.retry.toUpperCase(),
                  style: TextStyle(color: context.colors.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
