import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final void Function(String name, String slug) onCategoryTap;

  const CategoriesWidget({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.horizontalX2,
        itemCount: categories.length,
        separatorBuilder: (context, index) => horizontalSpace(AppSpacing.x1),
        itemBuilder: (context, index) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size.zero,
              padding: AppSpacing.horizontalVerticalX2,
            ),
            onPressed: () =>
                onCategoryTap(categories[index].name, categories[index].slug),
            child: Text(categories[index].name),
          );
        },
      ),
    );
  }
}
