import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/features/account/presentation/view/account_screen.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';
import 'package:shopping_app/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/home_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/categories_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class AppTabs {
  AppTabs._();

  static final List<Widget> tabs = [
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: serviceLocator<CategoriesCubit>()..intent(FetchCategories()),
        ),
        BlocProvider.value(
          value: serviceLocator<ProductsCubit>()..fetchFirstPage(),
        ),
      ],
      child: HomeScreen(),
    ),
    CartScreen(),
    BlocProvider.value(
      value: serviceLocator<FavouriteCubit>()..fetchFavourites(),
      child: const FavouriteScreen(),
    ),
    BlocProvider(
      create: (_) =>
      serviceLocator<AccountCubit>()..doIntent(GetUserDataIntent()),
      child: AccountScreen(),
    ),
  ];
}