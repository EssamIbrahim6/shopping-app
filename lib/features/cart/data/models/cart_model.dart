import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cart_entity.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int id;
  final String title;
  final String thumbnail;
  final double price;

  const CartModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  CartEntity toEntity({int quantity = 1}) {
    return CartEntity(
      id: id.toString(),
      title: title,
      thumbnail: thumbnail,
      price: price,
      quantity: quantity,
    );
  }
}
