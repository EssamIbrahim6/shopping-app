import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/domain/repo/search_products_by_category_repo_interface.dart';
import 'package:shopping_app/features/search/domain/use_case/search_products_by_category_use_case.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class FakeSearchProductsRepo implements SearchProductsByCategoryRepoInterface {
  FakeSearchProductsRepo({this.successProducts = const [], this.fail = false});

  final List<ProductItemEntity> successProducts;
  final bool fail;

  @override
  Future<ResultApi<List<ProductItemEntity>>> searchProductsByCategory(
    SearchProductsByCategoryRequestBody body,
  ) async {
    if (fail) return Error('Search failed');

    if (body.search.isEmpty) {
      return Success(const []);
    }

    if (body.skip > 0) {
      final end = (body.skip + body.limit).clamp(0, successProducts.length);
      return Success(successProducts.sublist(body.skip, end));
    }

    return Success(List<ProductItemEntity>.from(successProducts));
  }
}

void main() {
  group('SearchProductsByCategoryBloc', () {
    test(
      'emits loading and success states when a valid query is submitted',
      () async {
        final repo = FakeSearchProductsRepo(
          successProducts: [
            const ProductItemEntity(id: 1, title: 'Phone', isFavorite: false),
            const ProductItemEntity(id: 2, title: 'Laptop', isFavorite: false),
          ],
        );
        final bloc = SearchProductsByCategoryBloc(
          SearchProductsByCategoryUseCase(repo),
        );
        final states = <SearchProductsByCategoryState>[];
        final sub = bloc.stream.listen(states.add);

        bloc.add(
          const SearchQueryChanged(
            SearchProductsByCategoryRequestBody(search: 'phone'),
          ),
        );

        await Future<void>.delayed(const Duration(milliseconds: 600));

        expect(
          states.any((state) => state.searchState is BaseLoadingState),
          isTrue,
        );
        expect(
          bloc.state.searchState,
          isA<BaseSuccessState<List<ProductItemEntity>>>(),
        );
        expect(bloc.state.allProducts, hasLength(2));
        await sub.cancel();
      },
    );

    test(
      'clears the products and resets to initial state for an empty query',
      () async {
        final repo = FakeSearchProductsRepo(
          successProducts: [
            const ProductItemEntity(id: 9, title: 'Book', isFavorite: false),
          ],
        );
        final bloc = SearchProductsByCategoryBloc(
          SearchProductsByCategoryUseCase(repo),
        );

        bloc.add(
          const SearchQueryChanged(
            SearchProductsByCategoryRequestBody(search: 'phone'),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 600));
        bloc.add(
          const SearchQueryChanged(
            SearchProductsByCategoryRequestBody(search: ''),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 600));

        expect(
          bloc.state.searchState,
          isA<BaseInitialState<List<ProductItemEntity>>>(),
        );
        expect(bloc.state.allProducts, isEmpty);
      },
    );

    test('exposes a failure state when the repository request fails', () async {
      final bloc = SearchProductsByCategoryBloc(
        SearchProductsByCategoryUseCase(FakeSearchProductsRepo(fail: true)),
      );

      bloc.add(
        const SearchQueryChanged(
          SearchProductsByCategoryRequestBody(search: 'broken'),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(
        bloc.state.searchState,
        isA<BaseFailureState<List<ProductItemEntity>>>(),
      );
      expect(
        (bloc.state.searchState as BaseFailureState<List<ProductItemEntity>>)
            .errorMessage,
        'Search failed',
      );
    });

    test(
      'loads more products and appends them to the existing results',
      () async {
        final repo = FakeSearchProductsRepo(
          successProducts: List<ProductItemEntity>.generate(
            12,
            (index) => ProductItemEntity(
              id: index + 1,
              title: 'Item $index',
              isFavorite: false,
            ),
          ),
        );
        final bloc = SearchProductsByCategoryBloc(
          SearchProductsByCategoryUseCase(repo),
        );

        bloc.add(
          const SearchQueryChanged(
            SearchProductsByCategoryRequestBody(search: 'items', limit: 10),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 600));
        bloc.add(
          const LoadMoreProducts(
            SearchProductsByCategoryRequestBody(
              search: 'items',
              skip: 1,
              limit: 10,
            ),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 600));

        expect(bloc.state.allProducts, hasLength(12));
        expect(
          bloc.state.searchState,
          isA<BaseSuccessState<List<ProductItemEntity>>>(),
        );
        expect(bloc.state.isLoadingMore, isFalse);
      },
    );
  });
}
