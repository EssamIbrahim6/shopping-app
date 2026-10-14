import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:shopping_app/features/favourite/domain/use_case/get_favourites_usecase.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

@lazySingleton
class FavouriteCubit extends Cubit<BaseState<List<ProductItemEntity>>> {
  final GetFavouritesUseCase _getFavouritesUseCase;
  final FavouriteStatusService _favouriteStatusService;

  FavouriteCubit(this._getFavouritesUseCase, this._favouriteStatusService)
      : super(const BaseInitialState());

  void fetchFavourites() async {
    emit(const BaseLoadingState());
    final result = await _getFavouritesUseCase.invoke();
    switch (result) {
      case Success<List<ProductItemEntity>>():
        emit(BaseSuccessState(data: result.data));
      case Error<List<ProductItemEntity>>():
        emit(BaseFailureState(errorMessage: result.messageError));
    }
  }

  Future<ResultApi<bool>> toggleFavourite(int productId) async {
    final result = await _favouriteStatusService.toggle(productId);

    switch (result) {
      case Success<bool>():
        removeFavouriteItem(productId);

        // Sync the Home cubit's singleton instance
        serviceLocator<ProductsCubit>().updateFavoriteStatus(
          productId,
          false, // removed from favourites
        );
        if (serviceLocator.isRegistered<CategoryCubit>()) {
          serviceLocator<CategoryCubit>().updateFavoriteStatus(productId, false);
        }
      case Error<bool>():
        break;
    }

    return result;
  }

  void addFavouriteItem(ProductItemEntity product) {
    final currentState = state;
    if (currentState is BaseSuccessState<List<ProductItemEntity>>) {
      final alreadyExists = currentState.data.any((p) => p.id == product.id);
      if (!alreadyExists) {
        emit(BaseSuccessState(data: [...currentState.data, product]));
      }
    }
  }

  void removeFavouriteItem(int productId) {
    final currentState = state;
    if (currentState is BaseSuccessState<List<ProductItemEntity>>) {
      final updatedItems =
      currentState.data.where((p) => p.id != productId).toList();
      emit(BaseSuccessState(data: updatedItems));
    }
  }
}