import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class FavouriteShimmerWidget extends StatelessWidget {
  const FavouriteShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.disabled,
      highlightColor: AppColors.divider,
      child: GridView.builder(
        padding: AppSpacing.horizontalX2,
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.x2,
          crossAxisSpacing: AppSpacing.x2,
          childAspectRatio: 0.52,
        ),
        itemBuilder: (_, index) => Container(color: AppColors.surface),
      ),
    );
  }
}