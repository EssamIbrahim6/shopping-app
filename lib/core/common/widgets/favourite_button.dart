import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class FavouriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const FavouriteButton({
    super.key,
    required this.isFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.surface.withValues(alpha: .25),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: AppColors.primary,
          size: 18,
        ),
      ),
    );
  }
}