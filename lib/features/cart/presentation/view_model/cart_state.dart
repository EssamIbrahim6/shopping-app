import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import '../../domain/entities/cart_entity.dart';

@immutable
class CartState extends Equatable {
  final BaseState<List<CartEntity>> cartStatus;
  final bool isActionLoading;
  final String? actionError;

  const CartState({
    this.cartStatus = const BaseInitialState(),
    this.isActionLoading = false,
    this.actionError,
  });

  CartState copyWith({
    BaseState<List<CartEntity>>? cartStatus,
    bool? isActionLoading,
    String? actionError,
    bool clearActionError = false,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }

  @override
  List<Object?> get props => [cartStatus, isActionLoading, actionError];
}
