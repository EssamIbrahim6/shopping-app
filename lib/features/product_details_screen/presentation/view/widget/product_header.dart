import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.x1,
        vertical: AppSpacing.x1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.lightTheme.textTheme.headlineLarge),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EGP ${AppMethods.calculateDiscount(price, discount).toStringAsFixed(2)}',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                ),
              ),

              horizontalSpace(10),

              Padding(
                padding: EdgeInsets.only(top: AppSpacing.x1),
                child: Text(
                  'EGP ${price.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),

              horizontalSpace(10),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.x1,
                  vertical: AppSpacing.x1,
                ),
                decoration: AppStyles.customHeaderDecoration.copyWith(
                  borderRadius: BorderRadius.circular(AppSpacing.x2),
                ),
                child: Text(
                  '-${discount.toStringAsFixed(0)}%',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),

              // const Spacer(),
              horizontalSpace(30),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: AppColors.primary, size: 20),
              horizontalSpace(4),
              Text(
                rating.toStringAsFixed(1),
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            '($reviewCount reviews)',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
