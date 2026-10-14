import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/widget/product_description.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/widget/product_header.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/widget/product_image_carousel.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/widget/product_review.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view_model/cubit/product_details_cubit.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view_model/cubit/product_slider_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CarouselSliderController carouselcontroller =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<ProductSliderCubit>()),
        BlocProvider(
          create: (_) =>
              serviceLocator<ProductDetailsCubit>()
                ..intent(FetchProductDetails(widget.productId)),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<ProductDetailsCubit, ProductDetailsState>(
            listenWhen: (previous, current) =>
                previous is! ProductDetailsSuccess &&
                current is ProductDetailsSuccess,
            listener: (context, state) {
              if (state is ProductDetailsSuccess) {
                context.read<ProductSliderCubit>().syncFavoriteStatus(
                  state.product.id,
                );
              }
            },
            child: Scaffold(
              // تجنب الـ Overflow مع الكيبورد
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Stack(
                  children: [
                    // تم استخدام LayoutBuilder / CustomScrollView لحل مشكلة المساحات والأوفر فلو
                    Positioned.fill(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: AppSpacing.x2,
                          right: AppSpacing.x2,
                          top:
                              50, // مساحة علوية عشان زرار الرجوع ما يغطيش على أول السلايدر
                          bottom:
                              AppSpacing.x4, // مساحة سفيلة عشان الزرار اللي تحت
                        ),
                        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                          builder: (context, state) {
                            if (state is ProductDetailsLoading) {
                              return const SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (state is ProductDetailsFailure) {
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: Text(
                                    state.errorMessage,
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.error),
                                  ),
                                ),
                              );
                            }
                            if (state is ProductDetailsSuccess) {
                              final product = state.product;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<
                                    ProductSliderCubit,
                                    ProductSliderState
                                  >(
                                    builder: (context, sliderState) {
                                      return ProductImageCarousel(
                                        images: product.images,
                                        controller: carouselcontroller,
                                        isFav: () async {
                                          final result = await context
                                              .read<ProductSliderCubit>()
                                              .toggleFavorite(product);
                                          if (!context.mounted) return;
                                          switch (result) {
                                            case Success<bool>():
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    result.data
                                                        ? "Added to favourites"
                                                        : "Removed from favourites",
                                                  ),
                                                ),
                                              );
                                            case Error<bool>():
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    result.messageError,
                                                  ),
                                                ),
                                              );
                                          }
                                        },
                                        icon: sliderState.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.primary,
                                        index: sliderState.currentIndex,
                                        nextSlide: () =>
                                            carouselcontroller.nextPage(),
                                        prevSlide: () =>
                                            carouselcontroller.previousPage(),
                                        onPageChanged: (index, _) {
                                          context
                                              .read<ProductSliderCubit>()
                                              .intent(
                                                ProductSliderChangePage(index),
                                              );
                                        },
                                      );
                                    },
                                  ),
                                  ProductHeader(
                                    title: product.title,
                                    price: product.price,
                                    discount: product.discountPercentage,
                                    rating: product.rating,
                                    reviewCount: product.reviews.length,
                                  ),
                                  ProductDescription(
                                    description: product.description,
                                  ),
                                  ReviewsSection(reviews: product.reviews),
                                ],
                              );
                            }
                            return const SizedBox(
                              height: 300,
                              child: Center(child: Text('No data')),
                            );
                          },
                        ),
                      ),
                    ),
                    // زرار Back في مكان ثابت ومفهوش مشكلة
                    Positioned(
                      top: 10,
                      left: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.body,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(AppSpacing.x2),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SafeArea(
                  child: PrimaryBtn(
                    onPressed: () {
                      final state = context.read<ProductDetailsCubit>().state;
                      if (state is ProductDetailsSuccess) {
                        final product = state.product;
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
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.addedToCart),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: AppColors.background),
                        const SizedBox(width: 8),
                        Text(
                          'Add to cart',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.background,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
