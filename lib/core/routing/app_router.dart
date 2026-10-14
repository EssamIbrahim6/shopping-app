import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/screens/error_404_screen.dart';
import 'package:shopping_app/core/common/screens/launcher_screen.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/features/account/presentation/view/account_screen.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';
import 'package:shopping_app/features/auth/presentation/view/login_screen.dart';
import 'package:shopping_app/features/auth/presentation/view/register_screen.dart';
import 'package:shopping_app/features/auth/presentation/view_model/cubit/launcher/cubit/launcher_cubit.dart';
import 'package:shopping_app/features/auth/presentation/view_model/cubit/login/login_cubit.dart';
import 'package:shopping_app/features/auth/presentation/view_model/cubit/register/register_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/features/category/presentation/view/category_screen.dart';
import 'package:shopping_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:shopping_app/features/hello/presentation/view/screens/hello_screen.dart';

import 'package:shopping_app/features/hello/presentation/view_model/hello_cubit.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screen/onboarding_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/product_details_screen.dart';
import 'package:shopping_app/features/search/presentation/view/screens/search_products_by_category_screen.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.appSection:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: serviceLocator<AppSectionCubit>(),
            child: AppSectionScreen(),
          ),
        );

      case AppRoutes.cartScreen:
        return MaterialPageRoute(builder: (_) => CartScreen());

      case AppRoutes.favouriteScreen:
        return MaterialPageRoute(builder: (_) => const FavouriteScreen());

      case AppRoutes.accountScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                serviceLocator<AccountCubit>()..doIntent(GetUserDataIntent()),
            child: AccountScreen(),
          ),
        );

      case AppRoutes.onboardingRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<OnboardingCubit>(),
            child: OnboardingScreen(),
          ),
        );

      case AppRoutes.helloRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<HelloCubit>(),
            child: HelloScreen(),
          ),
        );

      case AppRoutes.launcherRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => serviceLocator<OnboardingCubit>()),
              BlocProvider(create: (_) => serviceLocator<HelloCubit>()),
              BlocProvider(create: (_) => serviceLocator<LauncherCubit>()),
            ],
            child: LauncherScreen(),
          ),
        );

      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<LoginCubit>(),
            child: LoginScreen(),
          ),
        );

      case AppRoutes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<RegisterCubit>(),
            child: RegisterScreen(),
          ),
        );

      case AppRoutes.productDetailsRoute:
        final productId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productId: productId),
        );

      case AppRoutes.productByCategoryRoute:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: serviceLocator<CategoryCubit>()
              ..fetchCategoryProducts(categoryName),
            child: CategoryScreen(categoryName: categoryName),
          ),
        );

      case AppRoutes.searchProductsByCategoryRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                serviceLocator<SearchProductsByCategoryBloc>()..add(Start()),
            child: SearchProductsByCategoryScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => Error404Screen());
    }
  }
}
