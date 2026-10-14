import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

class FavouriteEmpty extends StatelessWidget {
  const FavouriteEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite_border, size: 80, color: AppColors.heading),
            verticalSpace(AppSpacing.x2),
            Text(
              "There are no products in your\nfavourite list",
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}