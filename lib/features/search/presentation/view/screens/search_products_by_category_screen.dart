import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/presentation/view/widgets/search_body.dart';
import 'package:shopping_app/features/search/presentation/view/widgets/search_field.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class SearchProductsByCategoryScreen extends StatelessWidget {
  const SearchProductsByCategoryScreen({
    super.key,
    this.category = 'smartphones',
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    SearchProductsByCategoryRequestBody body() =>
        SearchProductsByCategoryRequestBody(
          search: searchController.text.trim(),
        );

    return Scaffold(
      appBar: AppBar(),
      body:
          BlocBuilder<
            SearchProductsByCategoryBloc,
            SearchProductsByCategoryState
          >(
            builder: (context, state) {
              final bloc = context.read<SearchProductsByCategoryBloc>();

              return Padding(
                padding: AppSpacing.allX1,
                child: Column(
                  children: [
                    SearchField(
                      controller: searchController,
                      onChanged: (value) {
                        bloc.add(
                          SearchQueryChanged(body().copyWith(search: value)),
                        );
                      },
                    ),

                    verticalSpace(AppSpacing.x2),

                    Expanded(
                      child: SearchBody(state: state, bloc: bloc, body: body),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
