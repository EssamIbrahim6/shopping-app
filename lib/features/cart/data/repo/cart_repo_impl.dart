import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repo/cart_repo_interface.dart';
import '../models/cart_model.dart';

@Injectable(as: CartRepoInterface)
class CartRepoImpl implements CartRepoInterface {
  final CartRemoteDataSource _remoteDataSource;

  CartRepoImpl(this._remoteDataSource);

  @override
  Future<ResultApi<List<CartEntity>>> getCart() async {
    try {
      final models = await _remoteDataSource.getCart();
      final Map<int, CartModel> uniqueProductsMap = {};
      final Map<int, int> quantitiesMap = {};

      for (var model in models) {
        if (quantitiesMap.containsKey(model.id)) {
          quantitiesMap[model.id] = quantitiesMap[model.id]! + 1;
        } else {
          quantitiesMap[model.id] = 1;
          uniqueProductsMap[model.id] = model;
        }
      }

      final List<CartEntity> entities = uniqueProductsMap.keys.map((id) {
        final model = uniqueProductsMap[id]!;
        final quantity = quantitiesMap[id]!;
        return model.toEntity(quantity: quantity);
      }).toList();

      return Success(entities);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> addToCart({required String productId}) async {
    try {
      await _remoteDataSource.addToCart(productId: productId);
      return Success(null);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> deleteCartItem({required String productId}) async {
    try {
      await _remoteDataSource.deleteCartItem(productId: productId);
      return Success(null);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> deleteAllCartItem({
    required String productId,
    required int quantity,
  }) async {
    try {
      for (int i = 0; i < quantity; i++) {
        await _remoteDataSource.deleteCartItem(productId: productId);
      }
      return Success(null);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e) {
      return Error(e.toString());
    }
  }
}
