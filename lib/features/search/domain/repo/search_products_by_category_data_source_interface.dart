import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';

abstract interface class SearchProductsByCategoryDataSourceInterface {
  Future<List<ProductItemDto>> searchProductsByCategory(
    SearchProductsByCategoryRequestBody body,
  );
}
