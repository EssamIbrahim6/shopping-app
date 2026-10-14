import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/favourite/presentation/view/widgets/favourite_empty.dart';
import 'package:shopping_app/features/favourite/presentation/view/widgets/favourite_shimmer_widget.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/product_details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const routeName = 'FavouriteScreen';

  void _handleFavouriteTap(BuildContext context, int productId) async {
    final cubit = context.read<FavouriteCubit>();
    final result = await cubit.toggleFavourite(productId);
    if (!context.mounted) return;

    switch (result) {
      case Success<bool>():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Removed from favourites")),
        );
      case Error<bool>():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.messageError)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('My Favourite', style: Theme.of(context).textTheme.headlineMedium),
          centerTitle: true,
        ),
        body: BlocBuilder<FavouriteCubit, BaseState<List<ProductItemEntity>>>(
          builder: (context, state) {
            return BaseStateBuilder<List<ProductItemEntity>>(
              state: state,
              onLoading: () => const FavouriteShimmerWidget(),
              onError: (message) => Center(
                child: Padding(
                  padding: AppSpacing.allX2,
                  child: Text(
                    message,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
              onSuccess: (products) {
                if (products.isEmpty) {
                  return const FavouriteEmpty();
                }
                return GridView.builder(
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
                      onFavorite: () => _handleFavouriteTap(context, product.id),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}