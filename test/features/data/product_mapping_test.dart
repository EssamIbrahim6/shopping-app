import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';

void main() {
  group('ProductItemDto', () {
    test('serializes and deserializes a product item from JSON', () {
      final json = {
        'id': 44,
        'title': 'Sneakers',
        'description': 'Running shoes',
        'category': 'sports',
        'price': 120.5,
        'discountPercentage': 15,
        'rating': 4.8,
        'stock': 22,
        'brand': 'Apex',
        'sku': 'APX-44',
        'weight': 320,
        'minimumOrderQuantity': 1,
        'tags': ['sale', 'new'],
        'images': ['img-1.png', 'img-2.png'],
        'thumbnail': 'thumb.png',
        'warrantyInformation': '1 year',
        'shippingInformation': 'Free shipping',
        'availabilityStatus': 'In stock',
        'returnPolicy': '30-day return',
        'reviews': [
          {
            'rating': 5,
            'comment': 'Great fit',
            'date': '2025-01-01',
            'reviewerName': 'Dana',
            'reviewerEmail': 'dana@example.com',
          },
        ],
        'dimensions': {'width': 11.2, 'height': 5.8, 'depth': 3.0},
      };

      final dto = ProductItemDto.fromJson(json);
      final entity = dto.toEntity();

      expect(dto.title, 'Sneakers');
      expect(entity.id, 44);
      expect(entity.price, 120.5);
      expect(entity.discountPercentage, 15);
      expect(entity.reviewCount, 1);
      expect(entity.reviews.first.reviewerName, 'Dana');
      expect(entity.dimensions.width, 11.2);
      expect(dto.toJson()['title'], 'Sneakers');
    });

    test('uses the default values when JSON properties are missing', () {
      final dto = ProductItemDto.fromJson({});
      final entity = dto.toEntity();

      expect(entity.title, isEmpty);
      expect(entity.price, 0);
      expect(entity.tags, isEmpty);
      expect(entity.images, isEmpty);
      expect(entity.reviewCount, 0);
      expect(entity.dimensions.width, 0);
    });
  });

  group('SearchProductsByCategoryRequestBody', () {
    test('round-trips through JSON and preserves copyWith values', () {
      const original = SearchProductsByCategoryRequestBody(
        search: 'camera',
        skip: 2,
        limit: 6,
      );

      final json = original.toJson();
      final restored = SearchProductsByCategoryRequestBody.fromJson(json);
      final updated = original.copyWith(search: 'phone', limit: 8);

      expect(restored.search, 'camera');
      expect(restored.skip, 2);
      expect(restored.limit, 6);
      expect(updated.search, 'phone');
      expect(updated.limit, 8);
    });
  });
}
