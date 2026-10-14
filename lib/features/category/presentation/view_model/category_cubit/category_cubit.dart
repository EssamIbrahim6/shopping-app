import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/paginated_cubit.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';
import '../../../domain/usecase/get_category_products_use_case.dart';

@lazySingleton
class CategoryCubit extends PaginatedCubit<ProductItemEntity> {
  final GetCategoryProductsUseCase getCategoryProductsUseCase;
  final FavouriteStatusService _favouriteStatusService;

  String? _categoryName;

  CategoryCubit(this.getCategoryProductsUseCase, this._favouriteStatusService)
      : super(pageSize: ApiConstants.pageLimit);

  void fetchCategoryProducts(String categoryName) {
    if (_categoryName != categoryName) {
      _categoryName = categoryName;
      fetchFirstPage();
    } else if (state.items.isEmpty && !state.isFirstLoading) {
      fetchFirstPage();
    }
  }

  @override
  Future<ResultApi<List<ProductItemEntity>>> fetchPage(int page) async {
    final categoryName = _categoryName;
    if (categoryName == null) {
      return Error('No category selected');
    }

    final skip = (page - 1) * pageSize;
    final result = await getCategoryProductsUseCase.invoke(
      categoryName,
      skip: skip,
      limit: pageSize,
    );

    switch (result) {
      case Success<List<ProductItemEntity>>():
        return Success(_applyFavouriteStatus(result.data));
      case Error<List<ProductItemEntity>>():
        return result;
    }
  }

  List<ProductItemEntity> _applyFavouriteStatus(List<ProductItemEntity> products) {
    return products
        .map((product) => product.copyWith(
      isFavorite: _favouriteStatusService.isFavourite(product.id),
    ))
        .toList();
  }

  void updateFavoriteStatus(int productId, bool isFavorite) {
    final updatedItems = state.items.map((product) {
      if (product.id == productId) {
        return product.copyWith(isFavorite: isFavorite);
      }
      return product;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  Future<ResultApi<bool>> toggleFavorite(int productId) async {
    final result = await _favouriteStatusService.toggle(productId);
    switch (result) {
      case Success<bool>():
        updateFavoriteStatus(productId, result.data);

        if (serviceLocator.isRegistered<ProductsCubit>()) {
          serviceLocator<ProductsCubit>().updateFavoriteStatus(productId, result.data);
        }

        if (serviceLocator.isRegistered<FavouriteCubit>()) {
          final favouriteCubit = serviceLocator<FavouriteCubit>();
          if (result.data) {
            final product = state.items.firstWhere((p) => p.id == productId);
            favouriteCubit.addFavouriteItem(product);
          } else {
            favouriteCubit.removeFavouriteItem(productId);
          }
        }
      case Error<bool>():
        break;
    }
    return result;
  }
}