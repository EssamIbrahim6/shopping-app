import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/common/widgets/error_info.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/common/widgets/product_card_shimmer.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/product_details_screen.dart';
import '../view_model/category_cubit/category_cubit.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({super.key, this.categoryName = 'beauty'});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategoryProducts(widget.categoryName);
  }

  @override
  void didUpdateWidget(covariant CategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryName != widget.categoryName) {
      context.read<CategoryCubit>().fetchCategoryProducts(widget.categoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryCubit, PaginationState<ProductItemEntity>>(
        builder: (context, state) {
          final cubit = context.read<CategoryCubit>();

          if (state.isFirstLoading) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: AppSpacing.horizontalX2,
              itemCount: 8,
              gridDelegate: AppStyles.productsGridDelegate,
              itemBuilder: (_, _) => ProductCardShimmer(),
            );
          }

          if (state.errorMessage != null && state.items.isEmpty) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.x2),
                child: Center(
                  child: ErrorInfo(
                    title: AppStrings.errorOccurred,
                    description: state.errorMessage!,
                    btnText: AppStrings.retry,
                    press: () => cubit.fetchCategoryProducts(widget.categoryName),
                  ),
                ),
              ),
            );
          }

          if (state.items.isEmpty) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.x2),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: SvgPicture.string(
                          AppAssets.error404Illustration,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    ErrorInfo(
                      title: AppStrings.noProductsFound,
                      description: AppStrings.noProductsFoundDesc,
                      btnText: AppStrings.retry,
                      press: () => cubit.fetchCategoryProducts(widget.categoryName),
                    ),
                  ],
                ),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 150) {
                cubit.fetchNextPage();
              }
              return false;
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(AppSpacing.x2),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.48,
                      crossAxisSpacing: AppSpacing.x2,
                      mainAxisSpacing: AppSpacing.x2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final product = state.items[index];
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
                            final result = await cubit.toggleFavorite(product.id);
                            if (!context.mounted) return;

                            switch (result) {
                              case Success<bool>():
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result.data
                                          ? "Added to favourites"
                                          : "Removed from favourites",
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
                      childCount: state.items.length,
                    ),
                  ),
                ),

                if (state.isLoadingMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.x2),
                      child: Shimmer.fromColors(
                        baseColor: AppColors.disabled,
                        highlightColor: AppColors.background,
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: AppSpacing.x2),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppSpacing.x1),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (!state.isLoadingMore && state.hasReachedMax && state.currentPage > 1)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.x2),
                      child: Center(
                        child: Text(
                          "No more products",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.disabled,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}