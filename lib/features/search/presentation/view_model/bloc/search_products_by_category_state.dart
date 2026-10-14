part of 'search_products_by_category_bloc.dart';

class SearchProductsByCategoryState extends Equatable {
  final BaseState<List<ProductItemEntity>> searchState;
  final int skip;
  final int limit;
  final bool hasMore;
  final bool isLoadingMore;
  final String? paginationError;
  final List<ProductItemEntity> allProducts;

  const SearchProductsByCategoryState({
    this.searchState = const BaseLoadingState(),
    this.skip = 0,
    this.limit = 10,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.paginationError,
    this.allProducts = const [],
  });

  SearchProductsByCategoryState copyWith({
    BaseState<List<ProductItemEntity>>? searchState,
    int? skip,
    int? limit,
    bool? hasMore,
    bool? isLoadingMore,
    String? paginationError,
    bool clearError = false,
    List<ProductItemEntity>? allProducts,
  }) {
    return SearchProductsByCategoryState(
      searchState: searchState ?? this.searchState,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      paginationError: clearError
          ? null
          : (paginationError ?? this.paginationError),
      allProducts: allProducts ?? this.allProducts,
    );
  }

  @override
  List<Object?> get props => [
    searchState,
    skip,
    limit,
    hasMore,
    isLoadingMore,
    paginationError,
    allProducts,
  ];
}
