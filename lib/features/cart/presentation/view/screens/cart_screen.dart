import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/features/cart/presentation/view/widgets/cart_item_card.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/cart/presentation/view/widgets/cart_item_shimmer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _didLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didLoad) {
      _didLoad = true;
      context.read<CartCubit>().doIntent(const GetCartEvent());
    }
  }

  void _showCheckoutAlert(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          ),
          child: Padding(
            padding: AppSpacing.allX3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: AppSpacing.allX2,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    boxShadow: [AppStyles.kBlackShadowSmall],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.onPrimary,
                    size: 40,
                  ),
                ),
                verticalSpace(AppSpacing.x3),
                Text(
                  AppStrings.cartCheckoutSuccessTitle,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: AppColors.success,
                  ),
                ),
                verticalSpace(AppSpacing.x2),
                Text(
                  AppStrings.cartCheckoutSuccessMessage,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.heading,
                  ),
                ),
                verticalSpace(AppSpacing.x4),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.x2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLg,
                        ),
                      ),
                    ),
                    child: Text(
                      AppStrings.ok,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _calculateSubtotal(List<CartEntity> cartItems) {
    double subtotal = 0.0;
    for (var item in cartItems) {
      subtotal += (item.price * item.quantity);
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.cartScreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.cartTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartStatus is BaseInitialState<List<CartEntity>>) {
              return _buildOnLoadingWidget();
            }

            return BaseStateBuilder<List<CartEntity>>(
              state: state.cartStatus,
              onLoading: () => _buildOnLoadingWidget(),
              onError: (error) => _buildOnFailureWidget(error, context),
              onSuccess: (cartItems) =>
                  _buildOnSuccessWidget(cartItems: cartItems, context: context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOnSuccessWidget({
    required List<CartEntity> cartItems,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.emptyCart, height: 200),
            verticalSpace(AppSpacing.x2),
            Text(
              AppStrings.cartEmptyState,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    final double subtotal = _calculateSubtotal(cartItems);
    const double shippingFee = 45.0;
    final double total = subtotal + shippingFee;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: AppSpacing.allX2,
            itemCount: cartItems.length,
            separatorBuilder: (_, _) => verticalSpace(AppSpacing.x2),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return CartItemCard(
                key: ValueKey('cart-item-${item.id}'),
                imageUrl: item.thumbnail,
                title: item.title,
                price: 'EGP ${item.price}',
                quantity: item.quantity,
                onIncrement: () {
                  context.read<CartCubit>().doIntent(
                    AddToCartEvent(productId: item.id),
                  );
                },
                onDecrement: () {
                  context.read<CartCubit>().doIntent(
                    DeleteCartItemEvent(productId: item.id),
                  );
                },
                onDelete: () {
                  context.read<CartCubit>().doIntent(
                    DeleteAllCartItemEvent(
                      productId: item.id,
                      quantity: item.quantity,
                    ),
                  );
                },
              );
            },
          ),
        ),

        Container(
          padding: AppSpacing.allX2,
          decoration: BoxDecoration(
            color: AppColors.cartSummaryBackground,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.cartShippingFee,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'EGP ${shippingFee.toStringAsFixed(0)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              verticalSpace(AppSpacing.x1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.cartSubTotal,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'EGP ${subtotal.toStringAsFixed(0)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Divider(height: 24, color: AppColors.cartDividerColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.cartTotal,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'EGP ${total.toStringAsFixed(0)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              verticalSpace(AppSpacing.x2),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.x2),
                    ),
                  ),
                  onPressed: () => _showCheckoutAlert(context),
                  child: Text(
                    AppStrings.cartCheckout,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOnFailureWidget(String error, BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.errorIcon, height: 96),
            verticalSpace(AppSpacing.x2),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnLoadingWidget({int itemCount = 4}) {
    return ListView.separated(
      padding: AppSpacing.allX2,
      itemCount: itemCount,
      separatorBuilder: (_, _) => verticalSpace(AppSpacing.x2),
      itemBuilder: (_, _) => const CartItemShimmer(),
    );
  }
}
