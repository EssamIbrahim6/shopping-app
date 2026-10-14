import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/extensions/navigation_extension.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.x2,
        AppSpacing.x2,
        AppSpacing.x2,
        AppSpacing.x1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.homeGreeting,
              style: theme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.x1),
          IconButton.filledTonal(
            tooltip: 'Search products',
            onPressed: () =>
                context.pushNamed(AppRoutes.searchProductsByCategoryRoute),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
