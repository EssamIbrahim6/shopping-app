import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';
import 'package:shopping_app/features/home/domain/use_case/get_products_usecase.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class FakeHomeRepo implements HomeRepoInterface {
  FakeHomeRepo({List<ProductItemEntity>? products, this.errorMessage})
    : _products = List<ProductItemEntity>.from(products ?? const []);

  final List<ProductItemEntity> _products;
  final String? errorMessage;

  @override
  Future<ResultApi<List<ProductItemEntity>>> getProducts({
    required int page,
  }) async {
    if (errorMessage != null) return Error(errorMessage!);
    return Success(List<ProductItemEntity>.from(_products));
  }

  @override
  Future<ResultApi<List<CategoryEntity>>> getCategories() async =>
      Success(const []);

  @override
  Future<ResultApi<ProductItemEntity>> getProductById({
    required int productId,
  }) async {
    final match = _products.firstWhere(
      (product) => product.id == productId,
      orElse: () => ProductItemEntity(id: productId),
    );
    return Success(match);
  }
}

class FakeFavouriteRepoForProducts implements FavouriteRepoInterface {
  FakeFavouriteRepoForProducts({List<int>? initialFavorites})
    : initialFavorites = List<int>.from(initialFavorites ?? const []);

  List<int> initialFavorites;

  @override
  Future<ResultApi<List<ProductItemEntity>>> getFavourites() async {
    return Success(
      initialFavorites
          .map(
            (id) =>
                ProductItemEntity(id: id, title: 'fav-$id', isFavorite: true),
          )
          .toList(),
    );
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async {
    if (!initialFavorites.contains(productId)) {
      initialFavorites.add(productId);
    }
    return Success('added-$productId');
  }

  @override
  Future<ResultApi<String>> removeFavourite(int productId) async {
    initialFavorites.remove(productId);
    return Success('removed-$productId');
  }
}

void main() {
  group('ProductsCubit', () {
    test(
      'fetches the first page of products and sets the page state',
      () async {
        final products = [
          const ProductItemEntity(
            id: 1,
            title: 'Phone',
            price: 200,
            isFavorite: false,
          ),
          const ProductItemEntity(
            id: 2,
            title: 'Tablet',
            price: 300,
            isFavorite: false,
          ),
        ];
        final repo = FakeHomeRepo(products: products);
        final favouriteRepo = FakeFavouriteRepoForProducts();
        final cubit = ProductsCubit(
          GetProductsUseCase(repo),
          FavouriteStatusService(favouriteRepo),
        );

        cubit.fetchFirstPage();
        await Future<void>.delayed(const Duration(milliseconds: 20));

        expect(cubit.state.items, hasLength(2));
        expect(cubit.state.currentPage, 1);
        expect(cubit.state.isFirstLoading, isFalse);
        expect(cubit.state.hasReachedMax, isTrue);
      },
    );

    test('stores the error message when product loading fails', () async {
      final cubit = ProductsCubit(
        GetProductsUseCase(FakeHomeRepo(errorMessage: 'Network error')),
        FavouriteStatusService(FakeFavouriteRepoForProducts()),
      );

      cubit.fetchFirstPage();
      await Future<void>.delayed(const Duration(milliseconds: 20));

      expect(cubit.state.errorMessage, 'Network error');
      expect(cubit.state.isFirstLoading, isFalse);
    });

    test('toggles favorite selection and updates the item status', () async {
      final product = const ProductItemEntity(
        id: 7,
        title: 'Watch',
        price: 150,
        isFavorite: false,
      );
      final favouriteRepo = FakeFavouriteRepoForProducts();
      final cubit = ProductsCubit(
        GetProductsUseCase(FakeHomeRepo(products: [product])),
        FavouriteStatusService(favouriteRepo),
      );

      cubit.emit(PaginationState(items: [product], currentPage: 1));
      final result = await cubit.toggleFavorite(7);

      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).data, isTrue);
      expect(cubit.state.items.first.isFavorite, isTrue);
    });
  });
}
