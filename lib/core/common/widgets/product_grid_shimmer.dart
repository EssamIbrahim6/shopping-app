import 'package:flutter/cupertino.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/common/widgets/product_card_shimmer.dart';

class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppSpacing.horizontalX2,
      gridDelegate: AppStyles.productsGridDelegate,
      itemCount: 8,
      itemBuilder: (_, _) => const ProductCardShimmer(),
    );
  }
}
