import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/extensions/shimmer_extension.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.allX1,
      decoration: AppStyles.customCardBoxDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.x2),
            child: Container(width: 80, height: 80, color: AppColors.surface),
          ).withShimmer(),
          horizontalSpace(AppSpacing.x1),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.x1),
                        child: Container(height: 14, color: AppColors.surface),
                      ).withShimmer(),
                    ),
                    horizontalSpace(AppSpacing.x3),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.x1),
                      child: Container(
                        width: 18,
                        height: 18,
                        color: AppColors.surface,
                      ),
                    ).withShimmer(),
                  ],
                ),
                verticalSpace(AppSpacing.x2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.x1),
                      child: Container(
                        width: 60,
                        height: 14,
                        color: AppColors.surface,
                      ),
                    ).withShimmer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.x1),
                      child: Container(
                        width: 70,
                        height: 28,
                        color: AppColors.surface,
                      ),
                    ).withShimmer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
