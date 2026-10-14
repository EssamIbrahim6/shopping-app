import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@LazySingleton(as: FavouriteRepoInterface)
class FavouriteRepoImpl implements FavouriteRepoInterface {
  final FavouriteDataSourceInterface _favouriteDataSource;
  FavouriteRepoImpl(this._favouriteDataSource);

  @override
  Future<ResultApi<List<ProductItemEntity>>> getFavourites() async {
    final result = await _favouriteDataSource.getFavourites();

    switch (result) {
      case Success<List<ProductItemDto>>():
        final entities = result.data
            .map((dto) => dto.toEntity().copyWith(isFavorite: true))
            .toList();
        return Success(entities);
      case Error<List<ProductItemDto>>():
        return Error(result.messageError);
    }
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async =>
      await _favouriteDataSource.addFavourite(productId);

  @override
  Future<ResultApi<String>> removeFavourite(int productId) async =>
      await _favouriteDataSource.removeFavourite(productId);
}