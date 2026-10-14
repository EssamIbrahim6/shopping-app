import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../repo/cart_repo_interface.dart';

@injectable
class DeleteCartItemUseCase {
  final CartRepoInterface _repo;

  DeleteCartItemUseCase(this._repo);

  Future<ResultApi<void>> invoke({required String productId}) async {
    return await _repo.deleteCartItem(productId: productId);
  }
}
