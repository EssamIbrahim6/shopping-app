import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

void main() {
  testWidgets(
    'ProductCard shows product metadata and executes add-to-cart action',
    (tester) async {
      var tapped = false;
      const product = ProductItemEntity(
        id: 15,
        title: 'Bluetooth Speaker',
        price: 199.99,
        discountPercentage: 10,
        rating: 4.7,
        reviewCount: 210,
        thumbnail: 'https://example.com/speaker.png',
        isFavorite: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 220,
                child: ProductCard(
                  product: product,
                  onAddToCart: () => tapped = true,
                  onFavorite: () {},
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Bluetooth Speaker'), findsOneWidget);
      expect(find.text('EGP 179.99'), findsOneWidget);
      expect(find.text('-10%'), findsOneWidget);

      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      expect(tapped, isTrue);
    },
  );
}
