import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

abstract interface class HomeRepoInterface {
  Future<ResultApi<List<CategoryEntity>>> getCategories();

  Future<ResultApi<List<ProductItemEntity>>> getProducts({
    required int page
  });
   Future<ResultApi<ProductItemEntity>> getProductById({
    required int productId
  });
}
