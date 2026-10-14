import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/paginated_cubit.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/home/domain/use_case/get_products_usecase.dart';

@lazySingleton
class ProductsCubit extends PaginatedCubit<ProductItemEntity> {
  ProductsCubit(this._getProductsUseCase, this._favouriteStatusService)
      : super(pageSize: ApiConstants.pageLimit);

  final GetProductsUseCase _getProductsUseCase;
  final FavouriteStatusService _favouriteStatusService;

  @override
  Future<ResultApi<List<ProductItemEntity>>> fetchPage(int page) async {
    final result = await _getProductsUseCase.invoke(page: page);
    switch (result) {
      case Success<List<ProductItemEntity>>():
        final mapped = result.data
            .map((product) => product.copyWith(
          isFavorite: _favouriteStatusService.isFavourite(product.id),
        ))
            .toList();
        return Success(mapped);
      case Error<List<ProductItemEntity>>():
        return result;
    }
  }

  Future<ResultApi<bool>> toggleFavorite(int productId) async {
    final result = await _favouriteStatusService.toggle(productId);
    switch (result) {
      case Success<bool>():
        updateFavoriteStatus(productId, result.data);

        if (serviceLocator.isRegistered<FavouriteCubit>()) {
          final favouriteCubit = serviceLocator<FavouriteCubit>();
          if (result.data) {
            final updatedProduct = state.items.firstWhere((p) => p.id == productId);
            favouriteCubit.addFavouriteItem(updatedProduct);
          } else {
            favouriteCubit.removeFavouriteItem(productId);
          }
        }

        if (serviceLocator.isRegistered<CategoryCubit>()) {
          serviceLocator<CategoryCubit>().updateFavoriteStatus(productId, result.data);
        }
      case Error<bool>():
        print("Toggle Favourite Error: ${result.messageError}");
        break;
    }
    return result;
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
}