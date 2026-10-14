import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

void main() {
  testWidgets('shopping theme renders primary actions accessibly', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          appBar: AppBar(title: const Text('Shop')),
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Explore'),
            ),
          ),
        ),
      ),
    );

    final theme = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!;
    final buttonStyle = theme.elevatedButtonTheme.style!;

    expect(find.text('Shop'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(buttonStyle.minimumSize!.resolve({}), const Size(48, 48));
    expect(AppStyles.productsGridDelegate.childAspectRatio, 0.68);
  });
}
