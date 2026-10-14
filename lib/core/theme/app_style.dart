import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

abstract final class AppStyles {
  static const BoxShadow defaultShadow = BoxShadow(
    color: Color(0x4DFF9900),
    offset: Offset(0, 4),
    blurRadius: 8,
  );

  static const BoxShadow primaryShadow = BoxShadow(
    color: Color(0x59FF9900),
    offset: Offset(0, 4),
    blurRadius: 10,
  );

  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color(0x59FF9900),
    offset: Offset(0, 4),
    blurRadius: 6,
  );
  static final ButtonStyle defaultStyle = ElevatedButton.styleFrom();

  static final ButtonStyle primaryStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
  );

  static final ButtonStyle secondaryStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.onPrimary,
    foregroundColor: AppColors.primary,
    shadowColor: Colors.transparent,
    elevation: 0,
    side: BorderSide(color: AppColors.primary),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.5)),
  );

  static BoxDecoration primaryDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFFFF9900), Color(0xFFFFB700)],
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [AppStyles.primaryShadow],
  );

  static BoxDecoration secondaryDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFFF9900), Color(0xFFFFB700)],
    ),
    borderRadius: BorderRadius.circular(12),
    // boxShadow: const [AppStyles.secondaryShadow],
  );

  static final BoxDecoration productCardDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(
      color: AppColors.background,
      width: 1.5,
      style: BorderStyle.solid,
    ),
    boxShadow: [kBlackShadowSmall],
  );
  static const BoxDecoration productImageDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  );
  static final BoxDecoration discountBadgeDecoration = BoxDecoration(
    color: AppColors.oragneLight.withValues(alpha: 0.3),
    borderRadius: BorderRadius.circular(16),
  );
  static const BoxShadow kOrangeShadowSmall = BoxShadow(
    color: Color(0x4DFF9900),
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );

  static const BoxShadow kOrangeShadowMedium = BoxShadow(
    color: Color(0x59FF9900),
    offset: Offset(0, 4),
    blurRadius: 16,
    spreadRadius: 0,
  );

  static const BoxShadow kOrangeShadowLarge = BoxShadow(
    color: Color(0x59FF9900), // 35% opacity
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );
  static BoxShadow kBlackShadowSmall = BoxShadow(
    color: Colors.black.withValues(alpha: .15),
    blurRadius: 10,
    offset: const Offset(0, 6),
  );
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(
      color: AppColors.background,
      width: 1.5,
      style: BorderStyle.solid,
    ),
    // boxShadow: const [AppStyles.defaultShadow],
  );
  static var productsGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: AppSpacing.x2,
    mainAxisSpacing: AppSpacing.x2,
    childAspectRatio: .55,
  );

  static BoxDecoration customCardBoxDecoration = BoxDecoration(
    color: AppColors.background, // cardBg,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
  static BoxDecoration customImageCardBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFFC84A),
        Color(0xFFFFC84A), // Light golden
        // Light golden
        // Color(0xFFF5A623), // Orange
        // Color(0xFFE88B00), // Dark orange
      ],
      stops: [0.0, 0.45, 1.0],
    ),
  );
  static BoxDecoration customImageCardBoxDecoration2 = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.purple],
      stops: [0.0, 0.45, 1.0],
    ),
  );
  static BoxDecoration favInProductDetailsDecoration = const BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
    ],
  );
  static BoxDecoration decorationImageSlider = BoxDecoration(
    color: const Color(0xFFF7F7F8),
    borderRadius: BorderRadius.circular(AppSpacing.x3),
  );
  static BoxDecoration customHeaderDecoration = BoxDecoration(
    color: const Color(0xffFFE9E2),
    borderRadius: BorderRadius.circular(10),
  );
}
