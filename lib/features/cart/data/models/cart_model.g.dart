// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  thumbnail: json['thumbnail'] as String,
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'thumbnail': instance.thumbnail,
  'price': instance.price,
};
