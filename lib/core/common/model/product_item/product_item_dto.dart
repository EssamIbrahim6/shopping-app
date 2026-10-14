import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';

part 'product_item_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductItemDto {
  const ProductItemDto({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  final int? id;

  @JsonKey(fromJson: _toString)
  final String? title;

  @JsonKey(fromJson: _toString)
  final String? description;

  @JsonKey(fromJson: _toString)
  final String? category;

  @JsonKey(fromJson: _toDouble)
  final double? price;

  @JsonKey(fromJson: _toDouble)
  final double? discountPercentage;

  @JsonKey(fromJson: _toDouble)
  final double? rating;

  final int? stock;
  final List<String>? tags;

  @JsonKey(fromJson: _toString)
  final String? brand;

  @JsonKey(fromJson: _toString)
  final String? sku;

  final int? weight;

  final DimensionsDto? dimensions;

  @JsonKey(fromJson: _toString)
  final String? warrantyInformation;

  @JsonKey(fromJson: _toString)
  final String? shippingInformation;

  @JsonKey(fromJson: _toString)
  final String? availabilityStatus;

  final List<ReviewDto>? reviews;

  @JsonKey(fromJson: _toString)
  final String? returnPolicy;

  final int? minimumOrderQuantity;

  final MetaDto? meta;

  final List<String>? images;

  @JsonKey(fromJson: _toString)
  final String? thumbnail;

  factory ProductItemDto.fromJson(Map<String, dynamic> json) =>
      _$ProductItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemDtoToJson(this);

  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      price: price ?? 0,
      discountPercentage: discountPercentage ?? 0,
      rating: rating ?? 0,
      stock: stock ?? 0,
      tags: tags ?? const [],
      brand: brand ?? '',
      sku: sku ?? '',
      weight: weight ?? 0,
      dimensions: dimensions?.toEntity() ?? const DimensionsEntity(),
      warrantyInformation: warrantyInformation ?? '',
      shippingInformation: shippingInformation ?? '',
      availabilityStatus: availabilityStatus ?? '',
      reviews: reviews?.map((e) => e.toEntity()).toList() ?? const [],
      returnPolicy: returnPolicy ?? '',
      minimumOrderQuantity: minimumOrderQuantity ?? 0,
      images: images ?? const [],
      thumbnail: thumbnail ?? '',
      reviewCount: reviews?.length ?? 0,
    );
  }

  static String? _toString(dynamic value) => value?.toString();

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}

@JsonSerializable()
class DimensionsDto {
  const DimensionsDto({this.width, this.height, this.depth});

  @JsonKey(fromJson: ProductItemDto._toDouble)
  final double? width;

  @JsonKey(fromJson: ProductItemDto._toDouble)
  final double? height;

  @JsonKey(fromJson: ProductItemDto._toDouble)
  final double? depth;

  factory DimensionsDto.fromJson(Map<String, dynamic> json) =>
      _$DimensionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsDtoToJson(this);

  DimensionsEntity toEntity() => DimensionsEntity(
    width: width ?? 0,
    height: height ?? 0,
    depth: depth ?? 0,
  );
}

@JsonSerializable()
class ReviewDto {
  const ReviewDto({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  final int? rating;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? comment;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? date;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? reviewerName;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? reviewerEmail;

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);

  ReviewEntity toEntity() => ReviewEntity(
    rating: rating ?? 0,
    comment: comment ?? '',
    date: date ?? '',
    reviewerName: reviewerName ?? '',
    reviewerEmail: reviewerEmail ?? '',
  );
}

@JsonSerializable()
class MetaDto {
  const MetaDto({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? createdAt;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? updatedAt;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? barcode;

  @JsonKey(fromJson: ProductItemDto._toString)
  final String? qrCode;

  factory MetaDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDtoToJson(this);
}
