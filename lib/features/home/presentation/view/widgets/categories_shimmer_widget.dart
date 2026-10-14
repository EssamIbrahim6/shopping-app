import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/extensions/shimmer_extension.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.horizontalX2,
        itemCount: itemCount,
        separatorBuilder: (_, _) => horizontalSpace(AppSpacing.x1),
        itemBuilder: (_, _) => const CategoryCardShimmer(),
      ),
    );
  }
}

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 96,
        height: 32,
        color: AppColors.surface,
      ).withShimmer(),
    );
  }
}
