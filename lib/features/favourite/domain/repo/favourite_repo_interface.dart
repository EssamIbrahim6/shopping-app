import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';

abstract interface class FavouriteRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> getFavourites();
  Future<ResultApi<String>> addFavourite(int productId);
  Future<ResultApi<String>> removeFavourite(int productId);
}