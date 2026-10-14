import 'package:shopping_app/core/common/model/defaults_values.dart';

typedef Tags = List<String>;
typedef Reviews = List<ReviewEntity>;
typedef Images = List<String>;

class ProductItemEntity {
  const ProductItemEntity({
    this.id = DefaultsValues.intValue,
    this.title = DefaultsValues.stringValue,
    this.description = DefaultsValues.stringValue,
    this.category = DefaultsValues.stringValue,
    this.brand = DefaultsValues.stringValue,
    this.sku = DefaultsValues.stringValue,
    this.price = DefaultsValues.doubleValue,
    this.discountPercentage = DefaultsValues.doubleValue,
    this.rating = DefaultsValues.doubleValue,
    this.stock = DefaultsValues.intValue,
    this.weight = DefaultsValues.intValue,
    this.minimumOrderQuantity = DefaultsValues.intValue,
    this.reviewCount = DefaultsValues.intValue,
    this.tags = const [],
    this.images = const [],
    this.dimensions = const DimensionsEntity(),
    this.reviews = const [],
    this.warrantyInformation = DefaultsValues.stringValue,
    this.shippingInformation = DefaultsValues.stringValue,
    this.availabilityStatus = DefaultsValues.stringValue,
    this.returnPolicy = DefaultsValues.stringValue,
    this.thumbnail = DefaultsValues.stringValue,
    this.isFavorite = DefaultsValues.boolValue,
  });

  // Identity
  final int id;

  // Basic Info
  final String title;
  final String description;
  final String category;
  final String brand;
  final String sku;

  // Pricing
  final double price;
  final double discountPercentage;
  final double rating;

  // Inventory
  final int stock;
  final int weight;
  final int minimumOrderQuantity;

  // Statistics
  final int reviewCount;

  // Collections
  final Tags tags;
  final Images images;
  final Reviews reviews;

  // Nested Models
  final DimensionsEntity dimensions;

  // Extra Information
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final String returnPolicy;

  // UI
  final String thumbnail;
  final bool isFavorite;

  ProductItemEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? brand,
    String? sku,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    int? weight,
    int? minimumOrderQuantity,
    int? reviewCount,
    Tags? tags,
    Images? images,
    Reviews? reviews,
    DimensionsEntity? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    String? returnPolicy,
    String? thumbnail,
    bool? isFavorite,
  }) {
    return ProductItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      weight: weight ?? this.weight,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      reviews: reviews ?? this.reviews,
      dimensions: dimensions ?? this.dimensions,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      thumbnail: thumbnail ?? this.thumbnail,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class DimensionsEntity {
  const DimensionsEntity({
    this.width = DefaultsValues.doubleValue,
    this.height = DefaultsValues.doubleValue,
    this.depth = DefaultsValues.doubleValue,
  });

  final double width;
  final double height;
  final double depth;

  DimensionsEntity copyWith({double? width, double? height, double? depth}) {
    return DimensionsEntity(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }
}

class ReviewEntity {
  const ReviewEntity({
    this.rating = DefaultsValues.intValue,
    this.comment = DefaultsValues.stringValue,
    this.date = DefaultsValues.stringValue,
    this.reviewerName = DefaultsValues.stringValue,
    this.reviewerEmail = DefaultsValues.stringValue,
  });

  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  ReviewEntity copyWith({
    int? rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  }) {
    return ReviewEntity(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerEmail: reviewerEmail ?? this.reviewerEmail,
    );
  }
}
