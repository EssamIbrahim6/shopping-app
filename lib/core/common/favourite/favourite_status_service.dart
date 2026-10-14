import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@lazySingleton
class FavouriteStatusService {
  final FavouriteRepoInterface _favouriteRepoInterface;
  FavouriteStatusService(this._favouriteRepoInterface);

  final Set<int> _favouriteIds = {};

  bool isFavourite(int productId) => _favouriteIds.contains(productId);

  Future<void> initialize() async {
    final result = await _favouriteRepoInterface.getFavourites();
    switch (result) {
      case Success<List<ProductItemEntity>>():
        _favouriteIds
          ..clear()
          ..addAll(result.data.map((e) => e.id));
      case Error<List<ProductItemEntity>>():
        break;
    }
  }

  Future<ResultApi<bool>> toggle(int productId) async {
    if (isFavourite(productId)) {
      final result = await _favouriteRepoInterface.removeFavourite(productId);
      switch (result) {
        case Success<String>():
          _favouriteIds.remove(productId);
          return Success(false);
        case Error<String>():
          return Error(result.messageError);
      }
    } else {
      final result = await _favouriteRepoInterface.addFavourite(productId);
      switch (result) {
        case Success<String>():
          _favouriteIds.add(productId);
          return Success(true);
        case Error<String>():
          return Error(result.messageError);
      }
    }
  }
}