import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';

abstract interface class SearchProductsByCategoryRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> searchProductsByCategory(
    SearchProductsByCategoryRequestBody body,
  );
}
