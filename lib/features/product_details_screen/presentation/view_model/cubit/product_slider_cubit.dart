import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

part 'product_slider_state.dart';

@injectable
class ProductSliderCubit extends Cubit<ProductSliderState> {
  final FavouriteStatusService _favouriteStatusService;

  ProductSliderCubit(this._favouriteStatusService) : super(const ProductSliderState());

  void intent(ProductSliderIntent intent) {
    switch (intent) {
      case ProductSliderChangeFavorite():
        emit(state.copyWith(isFavorite: intent.isFavorite));

      case ProductSliderChangePage():
        emit(state.copyWith(currentIndex: intent.index));
    }
  }

  /// يضبط حالة القلب من الـ FavouriteStatusService فعليًا بدل القيمة الافتراضية false
  void syncFavoriteStatus(int productId) {
    emit(state.copyWith(isFavorite: _favouriteStatusService.isFavourite(productId)));
  }

  /// يستدعي الـ API الحقيقي بدل تغيير الأيقونة بس محليًا
  Future<ResultApi<bool>> toggleFavorite(ProductItemEntity product) async {
    final result = await _favouriteStatusService.toggle(product.id);
    if (result is Success<bool>) {
      emit(state.copyWith(isFavorite: result.data));

      // تحديث حالة المنتج في الكيوبيت الخاص بالصفحة الرئيسية
      if (serviceLocator.isRegistered<ProductsCubit>()) {
        serviceLocator<ProductsCubit>().updateFavoriteStatus(product.id, result.data);
      }

      // تحديث حالة المنتج في الكيوبيت الخاص بصفحة الفئات
      if (serviceLocator.isRegistered<CategoryCubit>()) {
        serviceLocator<CategoryCubit>().updateFavoriteStatus(product.id, result.data);
      }

      // إضافة أو حذف المنتج من قائمة المفضلات
      if (serviceLocator.isRegistered<FavouriteCubit>()) {
        final favouriteCubit = serviceLocator<FavouriteCubit>();
        if (result.data) {
          favouriteCubit.addFavouriteItem(product.copyWith(isFavorite: true));
        } else {
          favouriteCubit.removeFavouriteItem(product.id);
        }
      }
    }
    return result;
  }
}

sealed class ProductSliderIntent extends Equatable {
  const ProductSliderIntent();

  @override
  List<Object?> get props => [];
}

class ProductSliderChangeFavorite extends ProductSliderIntent {
  final bool isFavorite;

  const ProductSliderChangeFavorite(this.isFavorite);

  @override
  List<Object?> get props => [isFavorite];
}

class ProductSliderChangePage extends ProductSliderIntent {
  final int index;

  const ProductSliderChangePage(this.index);

  @override
  List<Object?> get props => [index];
}