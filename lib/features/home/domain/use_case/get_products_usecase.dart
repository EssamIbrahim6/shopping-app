import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetProductsUseCase {
  final HomeRepoInterface _homeRepoInterface;

  GetProductsUseCase(this._homeRepoInterface);

  Future<ResultApi<List<ProductItemEntity>>> invoke({required int page}) {
    return _homeRepoInterface.getProducts(page: page);
  }
}
