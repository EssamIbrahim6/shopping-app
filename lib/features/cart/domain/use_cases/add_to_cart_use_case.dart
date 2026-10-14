import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../repo/cart_repo_interface.dart';

@injectable
class AddToCartUseCase {
  final CartRepoInterface _repo;

  AddToCartUseCase(this._repo);

  Future<ResultApi<void>> invoke({required String productId}) async {
    return await _repo.addToCart(productId: productId);
  }
}
