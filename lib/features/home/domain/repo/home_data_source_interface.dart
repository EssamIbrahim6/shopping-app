import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_dto.dart';

abstract interface class HomeDataSourceInterface {
  Future<ResultApi<CategoriesDto>> getCategories();

  Future<ResultApi<List<ProductItemDto>>> getProducts({required int page});
  Future<ResultApi<ProductItemDto>> getProductById({required int productId});
}
