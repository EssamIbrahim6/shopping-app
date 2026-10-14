import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/domain/use_case/search_products_by_category_use_case.dart';
import 'package:stream_transform/stream_transform.dart';
part 'search_products_by_category_event.dart';
part 'search_products_by_category_state.dart';

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

@injectable
class SearchProductsByCategoryBloc
    extends Bloc<SearchProductsByCategoryEvent, SearchProductsByCategoryState> {
  final SearchProductsByCategoryUseCase _useCase;
  SearchProductsByCategoryBloc(this._useCase)
    : super(SearchProductsByCategoryState()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<LoadMoreProducts>(_loadMoreProducts);
    on<Start>(_onStart);
  }

  bool get isLoadingMore => state.isLoadingMore;
  void _onStart(Start event, Emitter<SearchProductsByCategoryState> emit) {
    emit(
      state.copyWith(
        searchState: const BaseInitialState<List<ProductItemEntity>>(),
        skip: 0,
        hasMore: true,
        isLoadingMore: false,
        allProducts: const [],
        clearError: true,
      ),
    );
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchProductsByCategoryState> emit,
  ) async {
    if (event.body.search.isEmpty) {
      emit(
        state.copyWith(
          searchState: const BaseInitialState<List<ProductItemEntity>>(),
          skip: 0,
          hasMore: true,
          isLoadingMore: false,
          allProducts: [],
          clearError: true,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        searchState: const BaseLoadingState<List<ProductItemEntity>>(),
        skip: 0,
        hasMore: true,
        isLoadingMore: false,
        allProducts: [],
        clearError: true,
      ),
    );
    final result = await _useCase.invoke(event.body);
    switch (result) {
      case Success<List<ProductItemEntity>>():
        final newAllProducts = List<ProductItemEntity>.from(result.data);
        emit(
          state.copyWith(
            allProducts: newAllProducts,
            skip: state.skip + 1,
            hasMore: result.data.length >= state.limit,
            searchState: BaseSuccessState<List<ProductItemEntity>>(
              data: newAllProducts,
            ),
          ),
        );

      case Error<List<ProductItemEntity>>(messageError: final message):
        emit(
          state.copyWith(
            searchState: BaseFailureState<List<ProductItemEntity>>(
              errorMessage: message,
            ),
          ),
        );
    }
  }

  Future<void> _loadMoreProducts(
    LoadMoreProducts event,
    Emitter<SearchProductsByCategoryState> emit,
  ) async {
    final body = event.body;
    if (!state.hasMore ||
        state.isLoadingMore ||
        state.searchState is BaseLoadingState) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, clearError: true));
    final result = await _useCase.invoke(
      body.copyWith(skip: state.skip, limit: state.limit),
    );

    switch (result) {
      case Success<List<ProductItemEntity>>(data: final products):
        if (products.isEmpty) {
          emit(state.copyWith(hasMore: false, isLoadingMore: false));
        } else {
          final newAllProducts = List<ProductItemEntity>.from(state.allProducts)
            ..addAll(products);
          emit(
            state.copyWith(
              allProducts: newAllProducts,
              skip: state.skip + 1,
              hasMore: products.length >= state.limit,
              isLoadingMore: false,
              searchState: BaseSuccessState<List<ProductItemEntity>>(
                data: newAllProducts,
              ),
            ),
          );
        }
      case Error<List<ProductItemEntity>>(messageError: final message):
        emit(state.copyWith(isLoadingMore: false, paginationError: message));
    }
  }
}
