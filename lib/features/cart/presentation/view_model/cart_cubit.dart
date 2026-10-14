import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repo/cart_repo_interface.dart';
import 'cart_intent.dart';
import 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  final CartRepoInterface _cartRepo;

  CartCubit(this._cartRepo) : super(const CartState());

  void doIntent(CartIntent intent) {
    switch (intent) {
      case GetCartEvent():
        getCart();
        break;
      case AddToCartEvent():
        addToCart(
          productId: intent.productId.toString(),
          title: intent.title,
          price: intent.price,
          thumbnail: intent.thumbnail,
        );
        break;
      case DeleteCartItemEvent():
        deleteCartItem(productId: intent.productId.toString());
        break;
      case DeleteAllCartItemEvent():
        deleteAllCartItem(
          productId: intent.productId,
          quantity: intent.quantity,
        );
        break;
    }
  }

  Future<void> getCart() async {
    final hasData = state.cartStatus is BaseSuccessState<List<CartEntity>>;
    if (!hasData) {
      emit(state.copyWith(cartStatus: const BaseLoadingState()));
    }

    final result = await _cartRepo.getCart();

    switch (result) {
      case Success(data: final data):
        emit(state.copyWith(cartStatus: BaseSuccessState(data: data)));
        break;
      case Error(messageError: final message):
        if (hasData) return;
        emit(
          state.copyWith(cartStatus: BaseFailureState(errorMessage: message)),
        );
        break;
    }
  }

  Future<void> addToCart({
    required String productId,
    String? title,
    double? price,
    String? thumbnail,
  }) async {
    if (state.cartStatus is! BaseSuccessState<List<CartEntity>>) {
      await getCart();
    }

    _optimisticAdd(productId, title: title, price: price, thumbnail: thumbnail);

    await _executeAction(
      action: () => _cartRepo.addToCart(productId: productId),
      onSuccess: () => getCart(),
    );
  }

  Future<void> deleteCartItem({required String productId}) async {
    _optimisticRemove(productId);

    await _executeAction(
      action: () => _cartRepo.deleteCartItem(productId: productId),
      onSuccess: () => getCart(),
    );
  }

  Future<void> deleteAllCartItem({
    required String productId,
    required int quantity,
  }) async {
    _optimisticDeleteAll(productId);

    await _executeAction(
      action: () =>
          _cartRepo.deleteAllCartItem(productId: productId, quantity: quantity),
      onSuccess: () => getCart(),
    );
  }

  void _optimisticAdd(
    String productId, {
    String? title,
    double? price,
    String? thumbnail,
  }) {
    final current = state.cartStatus;

    List<CartEntity> items;
    if (current is BaseSuccessState<List<CartEntity>>) {
      items = List<CartEntity>.from(current.data);
    } else {
      items = [];
    }

    final index = items.indexWhere((item) => item.id == productId);
    if (index == -1) {
      if (title == null || price == null) return;
      items.add(
        CartEntity(
          id: productId,
          title: title,
          price: price,
          thumbnail: thumbnail ?? '',
          quantity: 1,
        ),
      );
    } else {
      final existing = items[index];
      items[index] = existing.copyWith(quantity: existing.quantity + 1);
    }

    emit(
      state.copyWith(
        cartStatus: BaseSuccessState<List<CartEntity>>(data: items),
      ),
    );
  }

  void _optimisticRemove(String productId) {
    final current = state.cartStatus;
    if (current is! BaseSuccessState<List<CartEntity>>) return;

    final items = List<CartEntity>.from(current.data);
    final index = items.indexWhere((item) => item.id == productId);
    if (index == -1) return;

    final existing = items[index];
    if (existing.quantity > 1) {
      items[index] = existing.copyWith(quantity: existing.quantity - 1);
    } else {
      items.removeAt(index);
    }

    emit(
      state.copyWith(
        cartStatus: BaseSuccessState<List<CartEntity>>(data: items),
      ),
    );
  }

  void _optimisticDeleteAll(String productId) {
    final current = state.cartStatus;
    if (current is! BaseSuccessState<List<CartEntity>>) return;

    final items = List<CartEntity>.from(current.data)
      ..removeWhere((item) => item.id == productId);

    emit(
      state.copyWith(
        cartStatus: BaseSuccessState<List<CartEntity>>(data: items),
      ),
    );
  }

  Future<void> _executeAction({
    required Future<ResultApi<void>> Function() action,
    required VoidCallback onSuccess,
  }) async {
    emit(state.copyWith(isActionLoading: true, clearActionError: true));

    final result = await action();

    emit(state.copyWith(isActionLoading: false));

    switch (result) {
      case Success():
        onSuccess();
        break;
      case Error(messageError: final message):
        emit(state.copyWith(actionError: message));
        break;
    }
  }
}
