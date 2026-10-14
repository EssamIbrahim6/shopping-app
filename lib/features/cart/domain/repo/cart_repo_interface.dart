import 'package:shopping_app/core/network/result_api.dart';
import '../entities/cart_entity.dart';

abstract class CartRepoInterface {
  Future<ResultApi<List<CartEntity>>> getCart();
  Future<ResultApi<void>> addToCart({required String productId});
  Future<ResultApi<void>> deleteCartItem({required String productId});
  Future<ResultApi<void>> deleteAllCartItem({
    required String productId,
    required int quantity,
  });
}
