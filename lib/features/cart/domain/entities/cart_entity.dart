class CartEntity {
  final String id;
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;

  const CartEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  CartEntity copyWith({
    String? id,
    String? title,
    String? thumbnail,
    double? price,
    int? quantity,
  }) {
    return CartEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
