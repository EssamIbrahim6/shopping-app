import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/common/widgets/favourite_button.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/utils/app_methods.dart';

class ProductCard extends StatelessWidget {
  final ProductItemEntity product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavorite;
  final Function()? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppStyles.customCardBoxDecoration,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildProductImage(), _buildProductDetails(theme)],
        ),
      ),
    );
  }

  Widget _buildProductDetails(ThemeData theme) {
    final hasDiscount = product.discountPercentage > 0;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.x1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: theme.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              verticalSpace(2),
              Row(
                spacing: 4,
                children: [
                  const Icon(Icons.star, color: AppColors.accentDark, size: 14),
                  Text(
                    product.rating.toString(),
                    style: theme.textTheme.bodySmall,
                  ),
                  Expanded(
                    child: Text(
                      "(${product.reviewCount})",
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Text(
                  "EGP ${AppMethods.calculateDiscount(product.price, product.discountPercentage).toStringAsFixed(2)}",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hasDiscount)
                Container(
                  height: 22,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x1 / 2,
                  ),
                  alignment: Alignment.center,
                  decoration: AppStyles.discountBadgeDecoration,
                  child: Text(
                    "-${product.discountPercentage.toStringAsFixed(0)}%",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.accentDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          verticalSpace(AppSpacing.x1 / 2),
          PrimaryBtn(
            onPressed: onAddToCart,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    AppStrings.addToCart,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: AppColors.surface,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.x1),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                fit: BoxFit.contain,
                placeholder: (_, _) =>
                    const Center(child: CupertinoActivityIndicator()),
                errorWidget: (_, _, _) =>
                    const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.x1,
            right: AppSpacing.x1,
            child: FavouriteButton(
              isFavorite: product.isFavorite,
              onTap: onFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
