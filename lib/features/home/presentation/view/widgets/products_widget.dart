import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class ProductsWidget extends StatelessWidget {
  final List<ProductItemEntity> products;

  const ProductsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text("No Products Found"));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.x2,
        crossAxisSpacing: AppSpacing.x2,
        childAspectRatio: 0.52,
      ),
      itemBuilder: (_, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onAddToCart: () {},
          onFavorite: () async {
            final cubit = context.read<ProductsCubit>();
            final result = await cubit.toggleFavorite(product.id);
            if (!context.mounted) return;
            switch (result) {
              case Success<bool>():
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      result.data ? "Added to favourites" : "Removed from favourites",
                    ),
                  ),
                );
              case Error<bool>():
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.messageError)),
                );
            }
          },
        );
      },
    );
  }
}