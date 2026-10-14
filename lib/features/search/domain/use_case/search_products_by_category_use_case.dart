import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/domain/repo/search_products_by_category_repo_interface.dart';

@injectable
class SearchProductsByCategoryUseCase {
  const SearchProductsByCategoryUseCase(this._repo);
  final SearchProductsByCategoryRepoInterface _repo;
  Future<ResultApi<List<ProductItemEntity>>> invoke(
    SearchProductsByCategoryRequestBody body,
  ) async {
    return await _repo.searchProductsByCategory(body);
  }
}
