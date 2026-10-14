import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/extensions/navigation_extension.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.allX2,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            AppStrings.homeGreeting,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          IconButton(
            onPressed: () =>
                context.pushNamed(AppRoutes.searchProductsByCategoryRoute),
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
