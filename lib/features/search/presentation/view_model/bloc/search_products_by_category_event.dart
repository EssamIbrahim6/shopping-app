part of 'search_products_by_category_bloc.dart';

sealed class SearchProductsByCategoryEvent extends Equatable {
  const SearchProductsByCategoryEvent();

  @override
  List<Object> get props => [];
}

final class SearchQueryChanged extends SearchProductsByCategoryEvent {
  final SearchProductsByCategoryRequestBody body;
  const SearchQueryChanged(this.body);

  @override
  List<Object> get props => [body];
}

final class LoadMoreProducts extends SearchProductsByCategoryEvent {
  final SearchProductsByCategoryRequestBody body;
  const LoadMoreProducts(this.body);

  @override
  List<Object> get props => [body];
}

final class Start extends SearchProductsByCategoryEvent {
  const Start();
  @override
  List<Object> get props => [];
}
