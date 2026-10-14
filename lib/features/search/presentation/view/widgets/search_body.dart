import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/app_error_widget.dart';
import 'package:shopping_app/core/common/widgets/product_grid_shimmer.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/presentation/view/widgets/search_results_grid.dart';
import 'package:shopping_app/features/search/presentation/view/widgets/start_search_widget.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
    required this.state,
    required this.bloc,
    required this.body,
  });

  final SearchProductsByCategoryState state;
  final SearchProductsByCategoryBloc bloc;
  final SearchProductsByCategoryRequestBody Function() body;

  @override
  Widget build(BuildContext context) {
    if (state.searchState is BaseInitialState) return const StartSearchWidget();
    return BaseStateBuilder<List<ProductItemEntity>>(
      state: state.searchState,
      onLoading: () => const ProductGridShimmer(),
      onError: (error) => AppErrorWidget(
        error: error,
        onRetry: () => bloc.add(SearchQueryChanged(body())),
      ),
      onSuccess: (products) => SearchResultsGrid(
        products: products,
        state: state,
        body: body,
        bloc: bloc,
      ),
    );
  }
}
