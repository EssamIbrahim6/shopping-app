import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.28,
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: AppColors.error,
            foregroundColor: AppColors.onPrimary,
            borderRadius: BorderRadius.circular(AppSpacing.x2),
            icon: Icons.delete_outline,
            label: 'Delete',
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: Container(
        padding: AppSpacing.allX2,
        decoration: AppStyles.customCardBoxDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.disabled,
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.disabled,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.bodyLight,
                  ),
                ),
              ),
            ),
            horizontalSpace(AppSpacing.x2),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      height: 1.3,
                    ),
                  ),
                  verticalSpace(AppSpacing.x1),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpace(AppSpacing.x1),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x1 / 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.oragneLight.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _QuantityButton(icon: Icons.remove, onTap: onDecrement),
                      SizedBox(
                        width: 30,
                        child: Text(
                          '$quantity',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.heading,
                              ),
                        ),
                      ),
                      _QuantityButton(icon: Icons.add, onTap: onIncrement),
                    ],
                  ),
                ),
                verticalSpace(AppSpacing.x1),
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(AppSpacing.x1),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.x1 / 2),
                    child: Text(
                      'Remove',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
