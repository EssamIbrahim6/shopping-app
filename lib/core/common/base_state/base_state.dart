sealed class BaseState<T> {
  const BaseState();
}

class BaseInitialState<T> extends BaseState<T> {
  const BaseInitialState();
}

class BaseLoadingState<T> extends BaseState<T> {
  const BaseLoadingState();
}

class BaseLoadMoreState<T> extends BaseState<T> {
  const BaseLoadMoreState();
}

class BaseSuccessState<T> extends BaseState<T> {
  final T data;
  const BaseSuccessState({required this.data});
}

class BaseFailureState<T> extends BaseState<T> {
  final String errorMessage;
  const BaseFailureState({required this.errorMessage});
}
