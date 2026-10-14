import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/extensions/shimmer_extension.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: AppSpacing.allX1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(color: AppColors.surface).withShimmer(),
              ),
            ),

            verticalSpace(AppSpacing.x1),
            _line(),
            verticalSpace(AppSpacing.x1),
            _line(width: 80, height: 12),
            verticalSpace(AppSpacing.x1),
            _line(width: 100, height: 18),
            verticalSpace(AppSpacing.x1),
            _line(),
            verticalSpace(AppSpacing.x2),
            _line(width: 120),
            verticalSpace(AppSpacing.x2),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 38,
                width: double.infinity,
                color: AppColors.surface,
              ).withShimmer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line({double width = double.infinity, double height = 12}) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surface,
    ).withShimmer();
  }
}
