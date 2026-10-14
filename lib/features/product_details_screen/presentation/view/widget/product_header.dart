import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/utils/app_methods.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({
    super.key,
    required this.title,
    required this.price,

    required this.discount,
    required this.rating,
    required this.reviewCount,
  });

  final String title;
  final double price;
  final double discount;
  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.x1,
        vertical: AppSpacing.x1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.headlineLarge),
          verticalSpace(AppSpacing.x1),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.x1,
            runSpacing: AppSpacing.x1,
            children: [
              Text(
                'EGP ${AppMethods.calculateDiscount(price, discount).toStringAsFixed(2)}',
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (discount > 0)
                Text(
                  'EGP ${price.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.bodyLight,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              if (discount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x1,
                    vertical: AppSpacing.x1 / 2,
                  ),
                  decoration: AppStyles.discountBadgeDecoration,
                  child: Text(
                    '-${discount.toStringAsFixed(0)}%',
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentDark,
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.accentDark, size: 18),
              horizontalSpace(AppSpacing.x1 / 2),
              Text(rating.toStringAsFixed(1), style: textTheme.titleSmall),
              horizontalSpace(AppSpacing.x1 / 2),
              Text('($reviewCount reviews)', style: textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
