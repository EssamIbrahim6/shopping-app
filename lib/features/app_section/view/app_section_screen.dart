import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_tabs.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<AppSectionCubit>(),
      child: BlocBuilder<AppSectionCubit, int>(
        builder: (context, selectedIndex) {
          return BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              int cartCount = 0;
              final cartStatus = cartState.cartStatus;
              if (cartStatus is BaseSuccessState<List<CartEntity>>) {
                cartCount = cartStatus.data.length;
              }

              return Scaffold(
                body: IndexedStack(
                  index: selectedIndex,
                  children: AppTabs.tabs,
                ),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) =>
                      context.read<AppSectionCubit>().changeTab(index),
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  destinations: [
                    NavigationDestination(
                      icon: ImageIcon(AssetImage(AppAssets.homeIcon)),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: _CartIconWithBadge(cartCount: cartCount),
                      label: 'Cart',
                    ),
                    NavigationDestination(
                      icon: ImageIcon(AssetImage(AppAssets.favouriteIcon)),
                      label: 'Favourites',
                    ),
                    NavigationDestination(
                      icon: ImageIcon(AssetImage(AppAssets.accountIcon)),
                      label: 'Account',
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CartIconWithBadge extends StatelessWidget {
  const _CartIconWithBadge({required this.cartCount});

  final int cartCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ImageIcon(AssetImage(AppAssets.cartIcon)),
        if (cartCount > 0)
          Positioned(
            right: -9,
            top: -7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              decoration: const BoxDecoration(
                color: AppColors.accentDark,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                cartCount > 99 ? '99+' : '$cartCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
