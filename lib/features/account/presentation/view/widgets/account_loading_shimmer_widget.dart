import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/extensions/shimmer_extension.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class AccountLoadingShimmer extends StatelessWidget {
  const AccountLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final isCompactHeight = constraints.maxHeight < 620;
        final horizontalPadding = isWide ? AppSpacing.x4 : AppSpacing.x2;
        final topSpacing = isCompactHeight ? AppSpacing.x1 : AppSpacing.x3;
        final imageSpacing = isCompactHeight ? AppSpacing.x3 : AppSpacing.x5;
        final fieldSpacing = isCompactHeight ? AppSpacing.x1 : AppSpacing.x2;
        final buttonSpacing = isCompactHeight ? AppSpacing.x3 : AppSpacing.x4;

        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                top: false,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        topSpacing,
                        horizontalPadding,
                        AppSpacing.x3,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          verticalSpace(topSpacing),
                          const Center(child: _ShimmerCircle()),
                          verticalSpace(imageSpacing),
                          const _ShimmerField(),
                          verticalSpace(fieldSpacing),
                          const _ShimmerField(),
                          verticalSpace(fieldSpacing),
                          const _ShimmerField(),
                          verticalSpace(fieldSpacing),
                          const _ShimmerField(),
                          const Spacer(),
                          verticalSpace(buttonSpacing),
                          const _ShimmerBox(height: 52, radius: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerCircle extends StatelessWidget {
  const _ShimmerCircle();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final imageSize = (screenWidth * 0.30)
        .clamp(96.0, 132.0)
        .toDouble();

    return ClipOval(
      child: Container(
        width: imageSize,
        height: imageSize,
        color: AppColors.surface,
      ).withShimmer(),
    );
  }
}

class _ShimmerField extends StatelessWidget {
  const _ShimmerField();

  @override
  Widget build(BuildContext context) {
    return const _ShimmerBox(height: 52, radius: 8);
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.height, required this.radius});

  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        color: AppColors.surface,
      ).withShimmer(),
    );
  }
}
