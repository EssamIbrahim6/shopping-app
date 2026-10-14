// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/account/data/repo/account_data_source_imp.dart' as _i831;
import '../../features/account/data/repo/account_repo_imp.dart' as _i781;
import '../../features/account/domain/repo/account_repo_interface.dart'
    as _i684;
import '../../features/account/domain/use_cases/edit_user_data_usecase.dart'
    as _i588;
import '../../features/account/domain/use_cases/get_user_data_usecase.dart'
    as _i140;
import '../../features/account/presentation/view_model/account_cubit.dart'
    as _i803;
import '../../features/app_section/view_model/app_section_cubit.dart' as _i437;
import '../../features/auth/data/repo/auth_data_source_imp.dart' as _i489;
import '../../features/auth/data/repo/auth_local_data_source_imp.dart' as _i830;
import '../../features/auth/data/repo/auth_repo_imp.dart' as _i39;
import '../../features/auth/domain/repo/auth_local_data_source_interface.dart'
    as _i570;
import '../../features/auth/domain/repo/auth_remote_data_source_interface.dart'
    as _i823;
import '../../features/auth/domain/repo/auth_repo_interface.dart' as _i389;
import '../../features/auth/domain/usecase/delete_token_usecase.dart' as _i335;
import '../../features/auth/domain/usecase/get_token_usecase.dart' as _i453;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/presentation/view_model/cubit/launcher/cubit/launcher_cubit.dart'
    as _i966;
import '../../features/auth/presentation/view_model/cubit/login/login_cubit.dart'
    as _i646;
import '../../features/auth/presentation/view_model/cubit/register/register_cubit.dart'
    as _i849;
import '../../features/cart/data/repo/cart_data_source_imp.dart' as _i615;
import '../../features/cart/data/repo/cart_repo_impl.dart' as _i234;
import '../../features/cart/domain/repo/cart_data_source_interface.dart'
    as _i1034;
import '../../features/cart/domain/repo/cart_repo_interface.dart' as _i76;
import '../../features/cart/domain/use_cases/add_to_cart_use_case.dart'
    as _i252;
import '../../features/cart/domain/use_cases/delete_cart_item_use_case.dart'
    as _i571;
import '../../features/cart/domain/use_cases/get_cart_use_case.dart' as _i176;
import '../../features/cart/presentation/view_model/cart_cubit.dart' as _i818;
import '../../features/category/data/repo/category_data_source_imp.dart'
    as _i758;
import '../../features/category/data/repo/category_repo_imp.dart' as _i610;
import '../../features/category/domain/repo/category_data_source_interface.dart'
    as _i575;
import '../../features/category/domain/repo/category_repo_interface.dart'
    as _i889;
import '../../features/category/domain/usecase/get_category_products_use_case.dart'
    as _i1029;
import '../../features/category/presentation/view_model/category_cubit/category_cubit.dart'
    as _i662;
import '../../features/favourite/data/repo/favourite_data_source_impl.dart'
    as _i924;
import '../../features/favourite/data/repo/favourite_repo_impl.dart' as _i345;
import '../../features/favourite/domain/repo/favourite_data_source_interface.dart'
    as _i215;
import '../../features/favourite/domain/repo/favourite_repo_interface.dart'
    as _i171;
import '../../features/favourite/domain/use_case/add_favourite_usecase.dart'
    as _i622;
import '../../features/favourite/domain/use_case/get_favourites_usecase.dart'
    as _i890;
import '../../features/favourite/domain/use_case/remove_favourite_usecase.dart'
    as _i824;
import '../../features/favourite/presentation/view_model/favourite_cubit.dart'
    as _i640;
import '../../features/hello/data/repos/hello_data_source_imp.dart' as _i474;
import '../../features/hello/data/repos/hello_repo_imp.dart' as _i138;
import '../../features/hello/domain/repo/hello_data_source_interface.dart'
    as _i289;
import '../../features/hello/domain/repo/hello_repo_interface.dart' as _i907;
import '../../features/hello/domain/usecases/has_visited_hello_use_case.dart'
    as _i603;
import '../../features/hello/domain/usecases/mark_hello_as_visited_use_case.dart'
    as _i189;
import '../../features/hello/presentation/view_model/hello_cubit.dart' as _i380;
import '../../features/home/data/repo/home_data_source_remote_impl.dart'
    as _i576;
import '../../features/home/data/repo/home_repo_impl.dart' as _i1024;
import '../../features/home/domain/repo/home_data_source_interface.dart'
    as _i273;
import '../../features/home/domain/repo/home_repo_interface.dart' as _i1027;
import '../../features/home/domain/use_case/get_categories_usecase.dart'
    as _i315;
import '../../features/home/domain/use_case/get_product_by_id_usecase.dart'
    as _i74;
import '../../features/home/domain/use_case/get_products_usecase.dart' as _i111;
import '../../features/home/presentation/view_model/categories_cubit.dart'
    as _i550;
import '../../features/home/presentation/view_model/products_cubit.dart'
    as _i915;
import '../../features/onboarding/data/data_source/onboarding_data_source_imp.dart'
    as _i180;
import '../../features/onboarding/data/data_source/onboarding_data_source_interface.dart'
    as _i4;
import '../../features/onboarding/data/repo/onboarding_repo_imp.dart' as _i371;
import '../../features/onboarding/domain/repo/onboarding_repo_interface.dart'
    as _i398;
import '../../features/onboarding/domain/use_case/is_onboarding_seen_usecase.dart'
    as _i608;
import '../../features/onboarding/domain/use_case/save_onboarding_seen_usecase.dart'
    as _i848;
import '../../features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart'
    as _i917;
import '../../features/product_details_screen/presentation/view_model/cubit/product_details_cubit.dart'
    as _i205;
import '../../features/product_details_screen/presentation/view_model/cubit/product_slider_cubit.dart'
    as _i542;
import '../../features/search/data/data_source/search_products_by_category_remote_data_source_impl.dart'
    as _i536;
import '../../features/search/data/repo/search_products_by_category_repo_impl.dart'
    as _i548;
import '../../features/search/domain/repo/search_products_by_category_data_source_interface.dart'
    as _i802;
import '../../features/search/domain/repo/search_products_by_category_repo_interface.dart'
    as _i347;
import '../../features/search/domain/use_case/search_products_by_category_use_case.dart'
    as _i279;
import '../../features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart'
    as _i832;
import '../common/favourite/favourite_status_service.dart' as _i384;
import '../network/dio_module.dart' as _i614;
import '../storage_helper/secure_storage_helper.dart' as _i510;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i510.SecureStorageHelper>(() => _i510.SecureStorageHelper());
    gh.lazySingleton<_i437.AppSectionCubit>(() => _i437.AppSectionCubit());
    gh.factory<_i570.AuthLocalDataSourceInterface>(
      () => _i830.AuthLocalDataSourceImp(gh<_i510.SecureStorageHelper>()),
    );
    gh.factory<_i289.HelloDataSourceInterface>(
      () => _i474.HelloDataSourceImp(),
    );
    gh.factory<_i907.HelloRepoInterface>(
      () => _i138.HelloRepoImp(gh<_i289.HelloDataSourceInterface>()),
    );
    gh.factory<_i4.OnboardingDataSourceInterface>(
      () => _i180.OnboardingDataSourceImp(),
    );
    gh.factory<_i398.OnboardingRepoInterface>(
      () => _i371.OnboardingRepoImp(
        onboardingDataSourceInterface: gh<_i4.OnboardingDataSourceInterface>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i510.SecureStorageHelper>()),
    );
    gh.factory<_i603.HasVisitedHelloUseCase>(
      () => _i603.HasVisitedHelloUseCase(gh<_i907.HelloRepoInterface>()),
    );
    gh.factory<_i189.MarkHelloAsVisitedUseCase>(
      () => _i189.MarkHelloAsVisitedUseCase(gh<_i907.HelloRepoInterface>()),
    );
    gh.factory<_i380.HelloCubit>(
      () => _i380.HelloCubit(
        gh<_i603.HasVisitedHelloUseCase>(),
        gh<_i189.MarkHelloAsVisitedUseCase>(),
      ),
    );
    gh.factory<_i575.CategoryDataSourceInterface>(
      () => _i758.CategoryDataSourceImp(gh<_i361.Dio>()),
    );
    gh.factory<_i823.AuthRemoteDataSourceInterface>(
      () => _i489.AuthDataSourceImp(gh<_i361.Dio>()),
    );
    gh.factory<_i889.CategoryRepoInterface>(
      () => _i610.CategoryRepoImp(gh<_i575.CategoryDataSourceInterface>()),
    );
    gh.factory<_i1034.CartRemoteDataSource>(
      () => _i615.CartRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i608.IsOnboardingSeenUseCase>(
      () => _i608.IsOnboardingSeenUseCase(gh<_i398.OnboardingRepoInterface>()),
    );
    gh.factory<_i848.SaveOnboardingSeenUseCase>(
      () =>
          _i848.SaveOnboardingSeenUseCase(gh<_i398.OnboardingRepoInterface>()),
    );
    gh.factory<_i1029.GetCategoryProductsUseCase>(
      () =>
          _i1029.GetCategoryProductsUseCase(gh<_i889.CategoryRepoInterface>()),
    );
    gh.lazySingleton<_i273.HomeDataSourceInterface>(
      () => _i576.HomeDataSourceRemoteImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i831.AccountRemoteDataSource>(
      () => _i831.AccountRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i215.FavouriteDataSourceInterface>(
      () => _i924.FavouriteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i802.SearchProductsByCategoryDataSourceInterface>(
      () => _i536.SearchProductsByCategoryRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i171.FavouriteRepoInterface>(
      () => _i345.FavouriteRepoImpl(gh<_i215.FavouriteDataSourceInterface>()),
    );
    gh.factory<_i917.OnboardingCubit>(
      () => _i917.OnboardingCubit(
        gh<_i848.SaveOnboardingSeenUseCase>(),
        gh<_i608.IsOnboardingSeenUseCase>(),
      ),
    );
    gh.factory<_i389.AuthRepoInterface>(
      () => _i39.AuthRepoImp(
        gh<_i823.AuthRemoteDataSourceInterface>(),
        gh<_i570.AuthLocalDataSourceInterface>(),
      ),
    );
    gh.lazySingleton<_i1027.HomeRepoInterface>(
      () => _i1024.HomeRepoImpl(gh<_i273.HomeDataSourceInterface>()),
    );
    gh.factory<_i76.CartRepoInterface>(
      () => _i234.CartRepoImpl(gh<_i1034.CartRemoteDataSource>()),
    );
    gh.lazySingleton<_i347.SearchProductsByCategoryRepoInterface>(
      () => _i548.SearchProductsByCategoryRepoImpl(
        gh<_i802.SearchProductsByCategoryDataSourceInterface>(),
      ),
    );
    gh.lazySingleton<_i818.CartCubit>(
      () => _i818.CartCubit(gh<_i76.CartRepoInterface>()),
    );
    gh.factory<_i252.AddToCartUseCase>(
      () => _i252.AddToCartUseCase(gh<_i76.CartRepoInterface>()),
    );
    gh.factory<_i571.DeleteCartItemUseCase>(
      () => _i571.DeleteCartItemUseCase(gh<_i76.CartRepoInterface>()),
    );
    gh.factory<_i176.GetCartUseCase>(
      () => _i176.GetCartUseCase(gh<_i76.CartRepoInterface>()),
    );
    gh.lazySingleton<_i684.AccountRepoInterface>(
      () => _i781.AccountRepoImpl(gh<_i831.AccountRemoteDataSource>()),
    );
    gh.factory<_i622.AddFavouriteUseCase>(
      () => _i622.AddFavouriteUseCase(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.factory<_i890.GetFavouritesUseCase>(
      () => _i890.GetFavouritesUseCase(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.factory<_i824.RemoveFavouriteUseCase>(
      () => _i824.RemoveFavouriteUseCase(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.lazySingleton<_i384.FavouriteStatusService>(
      () => _i384.FavouriteStatusService(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.factory<_i74.GetProductByIdUseCase>(
      () => _i74.GetProductByIdUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i205.ProductDetailsCubit>(
      () => _i205.ProductDetailsCubit(gh<_i74.GetProductByIdUseCase>()),
    );
    gh.lazySingleton<_i662.CategoryCubit>(
      () => _i662.CategoryCubit(
        gh<_i1029.GetCategoryProductsUseCase>(),
        gh<_i384.FavouriteStatusService>(),
      ),
    );
    gh.lazySingleton<_i640.FavouriteCubit>(
      () => _i640.FavouriteCubit(
        gh<_i890.GetFavouritesUseCase>(),
        gh<_i384.FavouriteStatusService>(),
      ),
    );
    gh.factory<_i335.DeleteTokenUseCase>(
      () => _i335.DeleteTokenUseCase(gh<_i389.AuthRepoInterface>()),
    );
    gh.factory<_i453.GetTokenUseCase>(
      () => _i453.GetTokenUseCase(gh<_i389.AuthRepoInterface>()),
    );
    gh.factory<_i911.LoginUsecase>(
      () => _i911.LoginUsecase(gh<_i389.AuthRepoInterface>()),
    );
    gh.factory<_i769.RegisterUseCase>(
      () => _i769.RegisterUseCase(gh<_i389.AuthRepoInterface>()),
    );
    gh.factory<_i588.EditUserDataUseCase>(
      () => _i588.EditUserDataUseCase(gh<_i684.AccountRepoInterface>()),
    );
    gh.factory<_i140.GetUserDataUseCase>(
      () => _i140.GetUserDataUseCase(gh<_i684.AccountRepoInterface>()),
    );
    gh.factory<_i966.LauncherCubit>(
      () => _i966.LauncherCubit(gh<_i453.GetTokenUseCase>()),
    );
    gh.factory<_i315.GetCategoriesUseCase>(
      () => _i315.GetCategoriesUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i111.GetProductsUseCase>(
      () => _i111.GetProductsUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i542.ProductSliderCubit>(
      () => _i542.ProductSliderCubit(gh<_i384.FavouriteStatusService>()),
    );
    gh.factory<_i849.RegisterCubit>(
      () => _i849.RegisterCubit(gh<_i769.RegisterUseCase>()),
    );
    gh.factory<_i646.LoginCubit>(
      () => _i646.LoginCubit(gh<_i911.LoginUsecase>()),
    );
    gh.factory<_i279.SearchProductsByCategoryUseCase>(
      () => _i279.SearchProductsByCategoryUseCase(
        gh<_i347.SearchProductsByCategoryRepoInterface>(),
      ),
    );
    gh.factory<_i832.SearchProductsByCategoryBloc>(
      () => _i832.SearchProductsByCategoryBloc(
        gh<_i279.SearchProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i550.CategoriesCubit>(
      () => _i550.CategoriesCubit(gh<_i315.GetCategoriesUseCase>()),
    );
    gh.lazySingleton<_i915.ProductsCubit>(
      () => _i915.ProductsCubit(
        gh<_i111.GetProductsUseCase>(),
        gh<_i384.FavouriteStatusService>(),
      ),
    );
    gh.factory<_i803.AccountCubit>(
      () => _i803.AccountCubit(
        gh<_i140.GetUserDataUseCase>(),
        gh<_i588.EditUserDataUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i614.DioModule {}
