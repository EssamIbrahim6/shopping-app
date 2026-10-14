import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../entities/cart_entity.dart';
import '../repo/cart_repo_interface.dart';

@injectable
class GetCartUseCase {
  final CartRepoInterface _repo;

  GetCartUseCase(this._repo);

  Future<ResultApi<List<CartEntity>>> invoke() async {
    return await _repo.getCart();
  }
}
