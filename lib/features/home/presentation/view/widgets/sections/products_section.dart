import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/common/widgets/product_card_shimmer.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/product_details_screen.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, PaginationState<ProductItemEntity>>(
      builder: (context, state) {
        if (state.isFirstLoading) return _buildOnLoadingWidget();
        if (state.errorMessage != null && state.items.isEmpty) {
          return _buildOnFailureWidget(state, context);
        }
        return _buildOnSuccessWidget(state, context, products: state.items);
      },
    );
  }

  Widget _buildOnLoadingWidget({int itemCount = 8}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: itemCount,
      gridDelegate: AppStyles.productsGridDelegate,
      itemBuilder: (_, _) => ProductCardShimmer(),
    );
  }

  Widget _buildOnSuccessWidget(
      PaginationState<ProductItemEntity> state,
      BuildContext context, {
        required List<ProductItemEntity> products,
      }) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          children: [
            verticalSpace(96),
            Image.asset(AppAssets.emptyProduct, height: 96),
            Text("No products available in this category right now."),
          ],
        ),
      );
    }

    // Keep the grid of already-loaded products visible, and only show
    // the "loading more" indicator below it instead of replacing the
    // whole grid with a single spinner.
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: AppSpacing.horizontalX2,
          itemCount: products.length,
          gridDelegate: AppStyles.productsGridDelegate,
          itemBuilder: (_, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(productId: product.id),
                  ),
                );
              },
              onAddToCart: () {
                context.read<CartCubit>().doIntent(
                  AddToCartEvent(
                    productId: product.id.toString(),
                    title: product.title,
                    price: product.price,
                    thumbnail: product.thumbnail,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(content: Text(AppStrings.addedToCart)));
              },
              onFavorite: () async {
                final result = await context.read<ProductsCubit>().toggleFavorite(product.id);
                if (!context.mounted) return;
                switch (result) {
                  case Success<bool>():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.data ? "Added to favourites" : "Removed from favourites")),
                    );
                  case Error<bool>():
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.messageError)));
                }
              },
            );
          },
        ),
        if (state.isLoadingMore)
          const Padding(
            padding: AppSpacing.allX2,
            child: Center(child: CupertinoActivityIndicator()),
          ),
      ],
    );
  }

  Widget _buildOnFailureWidget(PaginationState<ProductItemEntity> state, BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            verticalSpace(96),
            Image.asset(AppAssets.errorIcon, height: 96),
            Text(
              state.errorMessage!,
              textAlign: .center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}