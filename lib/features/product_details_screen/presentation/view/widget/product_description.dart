import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

class ProductDescription extends StatelessWidget {
  final String description;
  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Divider(thickness: 0.5),
        Text(
          "Description",
          style: AppTheme.lightTheme.textTheme.headlineMedium,
        ),
        Text(description, style: AppTheme.lightTheme.textTheme.bodyMedium),
        Divider(thickness: 0.5),
      ],
    );
  }
}
