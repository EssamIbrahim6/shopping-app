sealed class CartIntent {
  const CartIntent();
}

class GetCartEvent extends CartIntent {
  const GetCartEvent();
}

class AddToCartEvent extends CartIntent {
  const AddToCartEvent({
    required this.productId,
    this.title,
    this.price,
    this.thumbnail,
  });

  final String productId;
  final String? title;
  final double? price;
  final String? thumbnail;
}

class DeleteCartItemEvent extends CartIntent {
  const DeleteCartItemEvent({required this.productId});
  final String productId;
}

class DeleteAllCartItemEvent extends CartIntent {
  final String productId;
  final int quantity;
  const DeleteAllCartItemEvent({
    required this.productId,
    required this.quantity,
  });
}
