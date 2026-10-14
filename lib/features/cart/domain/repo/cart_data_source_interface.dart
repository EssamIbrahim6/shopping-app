import 'package:shopping_app/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartModel>> getCart();
  Future<void> addToCart({required String productId});
  Future<void> deleteCartItem({required String productId});
}
