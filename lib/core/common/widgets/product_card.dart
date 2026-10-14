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
import 'package:shopping_app/core/theme/app_theme.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppStyles.customCardBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildProductImage(), _buildProductDetails()],
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.x1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: AppTheme.lightTheme.textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              verticalSpace(4),
              Row(
                spacing: 4,
                children: [
                  const Icon(Icons.star, color: AppColors.primary, size: 14),
                  Text(
                    product.rating.toString(),
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  Expanded(
                    child: Text(
                      "(${product.reviewCount})",
                      style: AppTheme.lightTheme.textTheme.bodySmall,
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
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              product.discountPercentage.toDouble() > 0 ||
                      product.discountPercentage.toDouble() < 0
                  ? Container(
                      height: 22,
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.x1),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "-${product.discountPercentage.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          verticalSpace(8),
          // Add To Cart Button
          PrimaryBtn(
            onPressed: onAddToCart,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    AppStrings.addToCart,
                    style: AppTheme.lightTheme.textTheme.labelMedium,
                  ),
                ),
                const Icon(
                  Icons.add_shopping_cart_sharp,
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
            top: 8,
            right: 8,
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
