import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/core/utils/app_methods.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.reviews});

  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Reviews (${reviews.length})',
              style: AppTheme.lightTheme.textTheme.headlineMedium,
            ),
            const Spacer(),
          ],
        ),
        _buildProductReview(reviews),
      ],
    );
  }

  Widget _buildProductReview(List<ReviewEntity> reviews) {
    return Column(
      children: reviews.map((element) {
        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.x2),
          child: ProductReview(
            date: element.date,
            name: element.reviewerName,
            comment: element.comment,
            rating: element.rating,
          ),
        );
      }).toList(),
    );
  }
}

class ProductReview extends StatelessWidget {
  const ProductReview({
    super.key,
    required this.date,
    required this.name,
    required this.comment,
    required this.rating,
  });
  final String date;
  final String name;
  final String comment;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.reviewerBgColor,
          child: Icon(Icons.person, color: AppColors.reviewerAvatar),
        ),
        horizontalSpace(10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Text(
                    AppMethods.timeAgo(date),
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              _ratingStars(rating),
              Text(
                comment,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ratingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.primary,
          size: AppSpacing.x2,
        );
      }),
    );
  }
}
