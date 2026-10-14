import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../repo/category_repo_interface.dart';

@injectable
class GetCategoryProductsUseCase {
  final CategoryRepoInterface _repo;

  GetCategoryProductsUseCase(this._repo);

  Future<ResultApi<List<ProductItemEntity>>> invoke(
    String categoryName, {
    int skip = 0,
    int limit = 5,
  }) async {
    return await _repo.getProductsByCategory(
      categoryName,
      skip: skip,
      limit: limit,
    );
  }
}
