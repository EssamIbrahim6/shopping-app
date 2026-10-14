import 'package:bloc/bloc.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'pagination_state.dart';

abstract class PaginatedCubit<T> extends Cubit<PaginationState<T>> {
  final int pageSize;

  PaginatedCubit({this.pageSize = 20}) : super(PaginationState<T>.initial());

  Future<ResultApi<List<T>>> fetchPage(int page);

  void fetchFirstPage() async {
    if (state.isFirstLoading) return;

    emit(state.copyWith(isFirstLoading: true, clearError: true));
    try {
      var result = await fetchPage(1);
      switch (result) {
        case Success<List<T>>():
          emit(
            state.copyWith(
              items: result.data,
              currentPage: 1,
              isFirstLoading: false,
              hasReachedMax: result.data.length < pageSize,
              clearError: true,
            ),
          );
        case Error<List<T>>():
          emit(
            state.copyWith(
              isFirstLoading: false,
              errorMessage: result.messageError,
            ),
          );
      }
    } catch (e) {
      emit(state.copyWith(isFirstLoading: false, errorMessage: e.toString()));
    }
  }

  void fetchNextPage() async {
    if (state.isFirstLoading || state.isLoadingMore || state.hasReachedMax) return;

    emit(state.copyWith(isLoadingMore: true, clearError: true));
    try {
      var nextPage = state.currentPage + 1;
      var result = await fetchPage(nextPage);
      switch (result) {
        case Success<List<T>>():
          emit(
            state.copyWith(
              items: [...state.items, ...result.data],
              currentPage: nextPage,
              isLoadingMore: false,
              hasReachedMax: result.data.length < pageSize,
              clearError: true,
            ),
          );
        case Error<List<T>>():
          emit(
            state.copyWith(
              isLoadingMore: false,
              errorMessage: result.messageError,
            ),
          );
      }
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
    }
  }
}