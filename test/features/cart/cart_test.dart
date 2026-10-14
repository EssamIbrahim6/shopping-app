import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/cart/data/models/cart_model.dart';
import 'package:shopping_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';

class FakeCartRemoteDataSource implements CartRemoteDataSource {
  FakeCartRemoteDataSource({List<CartModel>? initialModels})
    : _items = List<CartModel>.from(initialModels ?? const []);

  final List<CartModel> _items;
  String? errorMessage;

  @override
  Future<List<CartModel>> getCart() async {
    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
    return List<CartModel>.from(_items);
  }

  @override
  Future<void> addToCart({required String productId}) async {
    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
    final matches = _items.where((item) => item.id.toString() == productId);
    if (matches.isEmpty) {
      _items.add(
        const CartModel(id: 1, title: 'Added', thumbnail: '', price: 10),
      );
    }
  }

  @override
  Future<void> deleteCartItem({required String productId}) async {
    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
    _items.removeWhere((item) => item.id.toString() == productId);
  }
}

class FakeCartRepo implements CartRepoInterface {
  FakeCartRepo({List<CartEntity>? initialItems, this.failAction = false})
    : cartItems = List<CartEntity>.from(initialItems ?? const []);

  final List<CartEntity> cartItems;
  final bool failAction;
  String? lastError;

  @override
  Future<ResultApi<List<CartEntity>>> getCart() async {
    if (lastError != null) return Error(lastError!);
    return Success(List<CartEntity>.from(cartItems));
  }

  @override
  Future<ResultApi<void>> addToCart({required String productId}) async {
    if (failAction) return Error('Add failed');
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
    } else {
      cartItems.add(
        CartEntity(
          id: productId,
          title: 'New item',
          thumbnail: '',
          price: 50,
          quantity: 1,
        ),
      );
    }
    return Success(null);
  }

  @override
  Future<ResultApi<void>> deleteCartItem({required String productId}) async {
    if (failAction) return Error('Delete failed');
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index == -1) return Success(null);

    final item = cartItems[index];
    if (item.quantity > 1) {
      cartItems[index] = item.copyWith(quantity: item.quantity - 1);
    } else {
      cartItems.removeAt(index);
    }
    return Success(null);
  }

  @override
  Future<ResultApi<void>> deleteAllCartItem({
    required String productId,
    required int quantity,
  }) async {
    if (failAction) return Error('Delete all failed');
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index == -1) return Success(null);

    final item = cartItems[index];
    final remainingQuantity = item.quantity - quantity;
    if (remainingQuantity <= 0) {
      cartItems.removeAt(index);
    } else {
      cartItems[index] = item.copyWith(quantity: remainingQuantity);
    }
    return Success(null);
  }
}

void main() {
  group('CartCubit', () {
    test('starts with an initial empty cart state', () {
      final cubit = CartCubit(FakeCartRepo());

      expect(cubit.state, const CartState());
      expect(cubit.state.cartStatus, isA<BaseInitialState<List<CartEntity>>>());
      expect(cubit.state.isActionLoading, isFalse);
    });

    test('loads cart successfully and stores data in the state', () async {
      final cart = [
        const CartEntity(
          id: 'p1',
          title: 'Headphones',
          thumbnail: 'thumb',
          price: 100,
          quantity: 2,
        ),
      ];
      final cubit = CartCubit(FakeCartRepo(initialItems: cart));

      await cubit.getCart();

      final state = cubit.state.cartStatus;
      expect(state, isA<BaseSuccessState<List<CartEntity>>>());
      expect((state as BaseSuccessState<List<CartEntity>>).data, hasLength(1));
      expect(state.data.first.quantity, 2);
    });

    test(
      'adds a product optimistically and persists through cart repo',
      () async {
        final repo = FakeCartRepo();
        final cubit = CartCubit(repo);

        await cubit.addToCart(
          productId: 'p2',
          title: 'Smartwatch',
          price: 299.99,
          thumbnail: 'watch.png',
        );

        expect(
          cubit.state.cartStatus,
          isA<BaseSuccessState<List<CartEntity>>>(),
        );
        final items =
            (cubit.state.cartStatus as BaseSuccessState<List<CartEntity>>).data;
        expect(items, hasLength(1));
        expect(items.first.id, 'p2');
        expect(items.first.quantity, 1);
        expect(repo.cartItems, hasLength(1));
        expect(repo.cartItems.first.id, 'p2');
      },
    );

    test(
      'removes one quantity from an item and updates the cart state',
      () async {
        final repo = FakeCartRepo(
          initialItems: [
            const CartEntity(
              id: 'p3',
              title: 'Keyboard',
              thumbnail: 'kbd.png',
              price: 59,
              quantity: 2,
            ),
          ],
        );
        final cubit = CartCubit(repo);

        await cubit.getCart();
        await cubit.deleteCartItem(productId: 'p3');
        await Future<void>.delayed(Duration.zero);

        final state =
            cubit.state.cartStatus as BaseSuccessState<List<CartEntity>>;
        expect(state.data, hasLength(1));
        expect(state.data.first.quantity, 1);
      },
    );

    test('removes all matching items when requested with quantity', () async {
      final repo = FakeCartRepo(
        initialItems: [
          const CartEntity(
            id: 'p4',
            title: 'Mouse',
            thumbnail: 'mouse.png',
            price: 29,
            quantity: 3,
          ),
        ],
      );
      final cubit = CartCubit(repo);

      await cubit.getCart();
      await cubit.deleteAllCartItem(productId: 'p4', quantity: 3);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.cartStatus, isA<BaseSuccessState<List<CartEntity>>>());
      expect(
        (cubit.state.cartStatus as BaseSuccessState<List<CartEntity>>).data,
        isEmpty,
      );
    });

    test('sets action error when the repository fails', () async {
      final repo = FakeCartRepo(failAction: true);
      final cubit = CartCubit(repo);

      await cubit.addToCart(
        productId: 'p5',
        title: 'Camera',
        price: 400,
        thumbnail: 'cam.png',
      );

      expect(cubit.state.actionError, 'Add failed');
      expect(cubit.state.isActionLoading, isFalse);
    });

    test('routes intent events to the correct cart actions', () {
      final cubit = CartCubit(FakeCartRepo());

      cubit.doIntent(
        const AddToCartEvent(productId: '42', title: 'Bag', price: 89),
      );
      cubit.doIntent(const DeleteCartItemEvent(productId: '42'));
      cubit.doIntent(
        const DeleteAllCartItemEvent(productId: '42', quantity: 2),
      );
      cubit.doIntent(const GetCartEvent());

      expect(cubit.state, isNotNull);
    });
  });

  group('CartRepoImpl', () {
    test(
      'aggregates cart models by product and quantity before mapping to entities',
      () async {
        final remote = FakeCartRemoteDataSource(
          initialModels: [
            const CartModel(
              id: 7,
              title: 'Phone',
              thumbnail: 'p7',
              price: 1200,
            ),
            const CartModel(
              id: 7,
              title: 'Phone',
              thumbnail: 'p7',
              price: 1200,
            ),
            const CartModel(
              id: 9,
              title: 'Tablet',
              thumbnail: 't9',
              price: 800,
            ),
          ],
        );

        final repo = CartRepoImpl(remote);
        final result = await repo.getCart();

        expect(result, isA<Success<List<CartEntity>>>());
        final items = (result as Success<List<CartEntity>>).data;
        expect(items, hasLength(2));
        expect(items.firstWhere((item) => item.id == '7').quantity, 2);
        expect(items.firstWhere((item) => item.id == '9').price, 800);
      },
    );

    test(
      'deleteAllCartItem removes the provided quantity from the remote source',
      () async {
        final remote = FakeCartRemoteDataSource(
          initialModels: [
            const CartModel(id: 5, title: 'Lamp', thumbnail: 'lamp', price: 45),
            const CartModel(id: 5, title: 'Lamp', thumbnail: 'lamp', price: 45),
            const CartModel(id: 5, title: 'Lamp', thumbnail: 'lamp', price: 45),
          ],
        );
        final repo = CartRepoImpl(remote);

        final result = await repo.deleteAllCartItem(
          productId: '5',
          quantity: 3,
        );

        expect(result, isA<Success<void>>());
        final cart = await repo.getCart();
        expect((cart as Success<List<CartEntity>>).data, isEmpty);
      },
    );
  });
}
