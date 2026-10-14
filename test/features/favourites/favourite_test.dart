import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/data/repo/favourite_repo_impl.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/favourite/domain/use_case/get_favourites_usecase.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';

class FakeFavouriteDataSource implements FavouriteDataSourceInterface {
  FakeFavouriteDataSource({this.favourites = const []});

  final List<ProductItemDto> favourites;
  bool shouldFail = false;

  @override
  Future<ResultApi<List<ProductItemDto>>> getFavourites() async {
    if (shouldFail) return Error('Failed to fetch favourites');
    return Success(List<ProductItemDto>.from(favourites));
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async {
    if (shouldFail) return Error('Add favourite failed');
    return Success('favorite-$productId');
  }

  @override
  Future<ResultApi<String>> removeFavourite(int productId) async {
    if (shouldFail) return Error('Remove favourite failed');
    return Success('removed-$productId');
  }
}

class FakeFavouriteRepo implements FavouriteRepoInterface {
  FakeFavouriteRepo({
    List<ProductItemEntity>? favourites,
    this.shouldFail = false,
  }) : _favourites = List<ProductItemEntity>.from(favourites ?? const []);

  final List<ProductItemEntity> _favourites;
  final bool shouldFail;

  @override
  Future<ResultApi<List<ProductItemEntity>>> getFavourites() async {
    if (shouldFail) return Error('Load favourites failed');
    return Success(List<ProductItemEntity>.from(_favourites));
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async {
    if (shouldFail) return Error('Add favourite failed');
    final exists = _favourites.any((item) => item.id == productId);
    if (!exists) {
      _favourites.add(
        ProductItemEntity(
          id: productId,
          title: 'Favorite $productId',
          isFavorite: true,
        ),
      );
    }
    return Success('favorite-$productId');
  }

  @override
  Future<ResultApi<String>> removeFavourite(int productId) async {
    if (shouldFail) return Error('Remove favourite failed');
    _favourites.removeWhere((item) => item.id == productId);
    return Success('removed-$productId');
  }
}

void main() {
  group('FavouriteStatusService', () {
    test('initializes the favourite set from the repository result', () async {
      final repo = FakeFavouriteRepo(
        favourites: [
          const ProductItemEntity(id: 1, title: 'A', isFavorite: true),
          const ProductItemEntity(id: 3, title: 'C', isFavorite: true),
        ],
      );
      final service = FavouriteStatusService(repo);

      await service.initialize();

      expect(service.isFavourite(1), isTrue);
      expect(service.isFavourite(3), isTrue);
      expect(service.isFavourite(2), isFalse);
    });

    test('toggles favourite state for add and remove cases', () async {
      final repo = FakeFavouriteRepo();
      final service = FavouriteStatusService(repo);

      final added = await service.toggle(8);

      expect(added, isA<Success<bool>>());
      expect((added as Success<bool>).data, isTrue);
      expect(service.isFavourite(8), isTrue);

      final removed = await service.toggle(8);

      expect(removed, isA<Success<bool>>());
      expect((removed as Success<bool>).data, isFalse);
      expect(service.isFavourite(8), isFalse);
    });
  });

  group('FavouriteCubit', () {
    test('fetches favourites and exposes a success state', () async {
      final repo = FakeFavouriteRepo(
        favourites: [
          const ProductItemEntity(id: 10, title: 'Phone', isFavorite: true),
        ],
      );
      final cubit = FavouriteCubit(
        GetFavouritesUseCase(repo),
        FavouriteStatusService(repo),
      );

      cubit.fetchFavourites();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state, isA<BaseSuccessState<List<ProductItemEntity>>>());
      final items =
          (cubit.state as BaseSuccessState<List<ProductItemEntity>>).data;
      expect(items, hasLength(1));
      expect(items.first.id, 10);
    });

    test(
      'adds and removes favourite items while preserving state coherence',
      () async {
        final repo = FakeFavouriteRepo(
          favourites: [
            const ProductItemEntity(id: 22, title: 'Watch', isFavorite: true),
          ],
        );
        final cubit = FavouriteCubit(
          GetFavouritesUseCase(repo),
          FavouriteStatusService(repo),
        );

        cubit.fetchFavourites();
        await Future<void>.delayed(const Duration(milliseconds: 10));
        cubit.addFavouriteItem(
          const ProductItemEntity(id: 44, title: 'Bag', isFavorite: true),
        );
        cubit.removeFavouriteItem(22);

        final items =
            (cubit.state as BaseSuccessState<List<ProductItemEntity>>).data;
        expect(items.any((item) => item.id == 44), isTrue);
        expect(items.any((item) => item.id == 22), isFalse);
      },
    );

    test(
      'toggleFavourite returns success and updates the repository status',
      () async {
        final repo = FakeFavouriteRepo();
        final service = FavouriteStatusService(repo);
        final cubit = FavouriteCubit(GetFavouritesUseCase(repo), service);

        final result = await cubit.toggleFavourite(5);

        expect(result, isA<Success<bool>>());
        expect((result as Success<bool>).data, isTrue);
        expect(service.isFavourite(5), isTrue);
      },
    );
  });

  group('FavouriteRepoImpl', () {
    test(
      'maps favourite DTOs to entities with the favourite flag enabled',
      () async {
        final dataSource = FakeFavouriteDataSource(
          favourites: [const ProductItemDto(id: 101, title: 'Jacket')],
        );
        final repo = FavouriteRepoImpl(dataSource);

        final result = await repo.getFavourites();

        expect(result, isA<Success<List<ProductItemEntity>>>());
        final items = (result as Success<List<ProductItemEntity>>).data;
        expect(items, hasLength(1));
        expect(items.first.id, 101);
        expect(items.first.isFavorite, isTrue);
      },
    );
  });
}
