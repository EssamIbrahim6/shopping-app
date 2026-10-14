import 'package:meta/meta.dart';

@immutable
class PaginationState<T> {
  final List<T> items;
  final int currentPage;
  final bool isFirstLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? errorMessage;

  const PaginationState({
    this.items = const [],
    this.currentPage = 1,
    this.isFirstLoading = false,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  factory PaginationState.initial() => PaginationState<T>();

  PaginationState<T> copyWith({
    List<T>? items,
    int? currentPage,
    bool? isFirstLoading,
    bool? isLoadingMore,
    bool? hasReachedMax,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      isFirstLoading: isFirstLoading ?? this.isFirstLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
