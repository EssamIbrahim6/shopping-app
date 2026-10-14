import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_shimmer_widget.dart';
import 'package:shopping_app/features/home/presentation/view_model/categories_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, BaseState<List<CategoryEntity>>>(
      builder: (context, state) {
        return BaseStateBuilder<List<CategoryEntity>>(
          state: state,
          onLoading: () => const CategoriesShimmer(),
          onError: (error) => _buildOnFailureWidget(error, context),
          onSuccess: (categories) => _buildOnSuccessWidget(
            categories: categories,
            onCategoryTap: (name, slug) {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.productByCategoryRoute, arguments: slug);
            },
          ),
        );
      },
    );
  }

  Widget _buildOnSuccessWidget({
    required List<CategoryEntity> categories,
    required void Function(String name, String slug) onCategoryTap,
  }) {
    if (categories.isEmpty) {
      return Center(
        child: Column(
          children: [
            verticalSpace(96),
            Image.asset(AppAssets.emptyProduct, height: 96),
            Text('No categories available at the moment.'),
          ],
        ),
      );
    }
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.horizontalX2,
        itemCount: categories.length,
        separatorBuilder: (_, _) => horizontalSpace(AppSpacing.x1),
        itemBuilder: (_, index) {
          final category = categories[index];
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size.zero,
              padding: AppSpacing.horizontalVerticalX2,
            ),
            onPressed: () => onCategoryTap(category.name, category.slug),
            child: Text(category.name),
          );
        },
      ),
    );
  }

  Widget _buildOnFailureWidget(String error, BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            Image.asset(AppAssets.errorIcon, height: 96),
            Text(
              error,
              textAlign: .center,
              style: TextStyle(color: AppColors.bodyLight),
            ),
          ],
        ),
      ),
    );
  }
}