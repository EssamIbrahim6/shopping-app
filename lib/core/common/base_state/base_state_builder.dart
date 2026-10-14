import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';

class BaseStateBuilder<T> extends StatelessWidget {
  const BaseStateBuilder({
    super.key,
    required this.state,
    required this.onSuccess,
    required this.onLoading,
    required this.onError,
    this.loadMoreWidget,
  });

  final BaseState<T> state;
  final Widget Function(T data) onSuccess;
  final Widget Function() onLoading;
  final Widget Function(String error) onError;
  final Widget? loadMoreWidget;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      BaseLoadingState() => onLoading(),
      BaseSuccessState(data: final data) => onSuccess(data),
      BaseFailureState(errorMessage: final message) => onError(message),
      BaseInitialState() => const SizedBox.shrink(),
      BaseLoadMoreState() => loadMoreWidget ?? const SizedBox.shrink(),
    };
  }
}
