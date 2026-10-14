import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/network/result_api.dart';

abstract interface class FavouriteDataSourceInterface {
  Future<ResultApi<List<ProductItemDto>>> getFavourites();
  Future<ResultApi<String>> addFavourite(int productId);
  Future<ResultApi<String>> removeFavourite(int productId);
}