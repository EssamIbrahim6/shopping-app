import 'package:flutter/material.dart';

class SharedItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final VoidCallback onTap;

  const SharedItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(image, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'EGP ${price.toStringAsFixed(0)}',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
