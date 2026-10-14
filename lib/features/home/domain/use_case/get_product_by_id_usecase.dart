import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetProductByIdUseCase {
  final HomeRepoInterface _homeRepo;

  GetProductByIdUseCase(this._homeRepo);

  Future<ResultApi<ProductItemEntity>> invoke({required int productId}) async {
    return await _homeRepo.getProductById(productId: productId);
  }
}
