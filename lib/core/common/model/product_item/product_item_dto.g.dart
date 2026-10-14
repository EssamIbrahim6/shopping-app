// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItemDto _$ProductItemDtoFromJson(
  Map<String, dynamic> json,
) => ProductItemDto(
  id: (json['id'] as num?)?.toInt(),
  title: ProductItemDto._toString(json['title']),
  description: ProductItemDto._toString(json['description']),
  category: ProductItemDto._toString(json['category']),
  price: ProductItemDto._toDouble(json['price']),
  discountPercentage: ProductItemDto._toDouble(json['discountPercentage']),
  rating: ProductItemDto._toDouble(json['rating']),
  stock: (json['stock'] as num?)?.toInt(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  brand: ProductItemDto._toString(json['brand']),
  sku: ProductItemDto._toString(json['sku']),
  weight: (json['weight'] as num?)?.toInt(),
  dimensions: json['dimensions'] == null
      ? null
      : DimensionsDto.fromJson(json['dimensions'] as Map<String, dynamic>),
  warrantyInformation: ProductItemDto._toString(json['warrantyInformation']),
  shippingInformation: ProductItemDto._toString(json['shippingInformation']),
  availabilityStatus: ProductItemDto._toString(json['availabilityStatus']),
  reviews: (json['reviews'] as List<dynamic>?)
      ?.map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  returnPolicy: ProductItemDto._toString(json['returnPolicy']),
  minimumOrderQuantity: (json['minimumOrderQuantity'] as num?)?.toInt(),
  meta: json['meta'] == null
      ? null
      : MetaDto.fromJson(json['meta'] as Map<String, dynamic>),
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  thumbnail: ProductItemDto._toString(json['thumbnail']),
);

Map<String, dynamic> _$ProductItemDtoToJson(ProductItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'tags': instance.tags,
      'brand': instance.brand,
      'sku': instance.sku,
      'weight': instance.weight,
      'dimensions': instance.dimensions?.toJson(),
      'warrantyInformation': instance.warrantyInformation,
      'shippingInformation': instance.shippingInformation,
      'availabilityStatus': instance.availabilityStatus,
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
      'returnPolicy': instance.returnPolicy,
      'minimumOrderQuantity': instance.minimumOrderQuantity,
      'meta': instance.meta?.toJson(),
      'images': instance.images,
      'thumbnail': instance.thumbnail,
    };

DimensionsDto _$DimensionsDtoFromJson(Map<String, dynamic> json) =>
    DimensionsDto(
      width: ProductItemDto._toDouble(json['width']),
      height: ProductItemDto._toDouble(json['height']),
      depth: ProductItemDto._toDouble(json['depth']),
    );

Map<String, dynamic> _$DimensionsDtoToJson(DimensionsDto instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };

ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) => ReviewDto(
  rating: (json['rating'] as num?)?.toInt(),
  comment: ProductItemDto._toString(json['comment']),
  date: ProductItemDto._toString(json['date']),
  reviewerName: ProductItemDto._toString(json['reviewerName']),
  reviewerEmail: ProductItemDto._toString(json['reviewerEmail']),
);

Map<String, dynamic> _$ReviewDtoToJson(ReviewDto instance) => <String, dynamic>{
  'rating': instance.rating,
  'comment': instance.comment,
  'date': instance.date,
  'reviewerName': instance.reviewerName,
  'reviewerEmail': instance.reviewerEmail,
};

MetaDto _$MetaDtoFromJson(Map<String, dynamic> json) => MetaDto(
  createdAt: ProductItemDto._toString(json['createdAt']),
  updatedAt: ProductItemDto._toString(json['updatedAt']),
  barcode: ProductItemDto._toString(json['barcode']),
  qrCode: ProductItemDto._toString(json['qrCode']),
);

Map<String, dynamic> _$MetaDtoToJson(MetaDto instance) => <String, dynamic>{
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'barcode': instance.barcode,
  'qrCode': instance.qrCode,
};
