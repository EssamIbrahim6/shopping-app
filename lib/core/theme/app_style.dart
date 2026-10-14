import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

abstract final class AppStyles {
  static const BoxShadow defaultShadow = BoxShadow(
    color: Color(0x120D0B35),
    offset: Offset(0, 3),
    blurRadius: 12,
  );

  static const BoxShadow primaryShadow = BoxShadow(
    color: Color(0x266C63FF),
    offset: Offset(0, 5),
    blurRadius: 14,
  );

  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color(0x1F6C63FF),
    offset: Offset(0, 3),
    blurRadius: 8,
  );

  static final ButtonStyle defaultStyle = ElevatedButton.styleFrom();

  static final ButtonStyle primaryStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.onPrimary,
    shadowColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    ),
  );

  static final ButtonStyle secondaryStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.primary,
    shadowColor: Colors.transparent,
    elevation: 0,
    side: const BorderSide(color: AppColors.border),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    ),
  );

  static final BoxDecoration primaryDecoration = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
  );

  static final BoxDecoration secondaryDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    border: Border.all(color: AppColors.border),
  );

  static final BoxDecoration productCardDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
    border: Border.all(color: AppColors.border),
    boxShadow: const [defaultShadow],
  );

  static const BoxDecoration productImageDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  );

  static final BoxDecoration discountBadgeDecoration = BoxDecoration(
    color: AppColors.accentLight,
    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
  );

  static const BoxShadow kOrangeShadowSmall = primaryShadow;
  static const BoxShadow kOrangeShadowMedium = primaryShadow;
  static const BoxShadow kOrangeShadowLarge = primaryShadow;

  static const BoxShadow kBlackShadowSmall = BoxShadow(
    color: Color(0x120D0B35),
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  static final BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
    border: Border.all(color: AppColors.border),
  );

  static const SliverGridDelegateWithFixedCrossAxisCount productsGridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.x2,
        mainAxisSpacing: AppSpacing.x2,
        childAspectRatio: 0.68,
      );

  static final BoxDecoration customCardBoxDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
    border: Border.all(color: AppColors.border),
    boxShadow: const [defaultShadow],
  );

  static final BoxDecoration customImageCardBoxDecoration = BoxDecoration(
    color: AppColors.primaryLight,
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
  );

  static final BoxDecoration customImageCardBoxDecoration2 = BoxDecoration(
    color: AppColors.accentLight,
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
  );

  static const BoxDecoration favInProductDetailsDecoration = BoxDecoration(
    color: AppColors.surface,
    shape: BoxShape.circle,
    boxShadow: [defaultShadow],
  );

  static final BoxDecoration decorationImageSlider = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(AppSpacing.x3),
  );

  static final BoxDecoration customHeaderDecoration = BoxDecoration(
    color: AppColors.accentLight,
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
  );
}
