import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/presentation/view/widgets/search_body.dart';
import 'package:shopping_app/features/search/presentation/view/widgets/search_field.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class SearchProductsByCategoryScreen extends StatefulWidget {
  const SearchProductsByCategoryScreen({
    super.key,
    this.category = 'smartphones',
  });

  final String category;

  @override
  State<SearchProductsByCategoryScreen> createState() =>
      _SearchProductsByCategoryScreenState();
}

class _SearchProductsByCategoryScreenState
    extends State<SearchProductsByCategoryScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
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
                      controller: _searchController,
                      onChanged: (value) {
                        bloc.add(
                          SearchQueryChanged(
                            SearchProductsByCategoryRequestBody(
                              search: value.trim(),
                            ),
                          ),
                        );
                      },
                    ),

                    verticalSpace(AppSpacing.x2),

                    Expanded(
                      child: SearchBody(
                        state: state,
                        bloc: bloc,
                        body: () => SearchProductsByCategoryRequestBody(
                          search: _searchController.text.trim(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
