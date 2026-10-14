import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class GetFavouritesUseCase {
  final FavouriteRepoInterface _favouriteRepoInterface;
  GetFavouritesUseCase(this._favouriteRepoInterface);

  Future<ResultApi<List<ProductItemEntity>>> invoke() async =>
      await _favouriteRepoInterface.getFavourites();
}