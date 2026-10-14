import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';

@LazySingleton(as: FavouriteDataSourceInterface)
class FavouriteDataSourceImpl implements FavouriteDataSourceInterface {
  final Dio _dio;
  FavouriteDataSourceImpl(this._dio);

  @override
  Future<ResultApi<List<ProductItemDto>>> getFavourites() async {
    try {
      final response = await _dio.get(ApiConstants.getFavorite);

      if (response.statusCode == 200) {
        final List<dynamic> outerList = response.data['list'] ?? [];
        if (outerList.isNotEmpty) {
          final Map<String, dynamic> innerMap = outerList.first;
          final List<dynamic> productsList = innerMap['list'] ?? [];
          final products = productsList
              .map((e) => ProductItemDto.fromJson(e as Map<String, dynamic>))
              .toList();

          return Success(products);
        }
        return Success([]);
      }
      return Error("Failed to load favourites: Status ${response.statusCode}");
    } on DioException catch (e) {
      return Error(_mapError(e));
    } catch (e, stackTrace) {
      print('Parsing Error: $e');
      print('StackTrace: $stackTrace');
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async {
    try {
      final response = await _dio.post(
        ApiConstants.addFavorite,
        data: {'productId': productId.toString()},
      );

      if (response.statusCode == 200) {
        return Success(response.data['message'] ?? 'Added to favourites');
      }
      return Error("Failed to add favourite: Status ${response.statusCode}");
    } on DioException catch (e) {
      return Error(_mapError(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> removeFavourite(int productId) async {
    try {
      final response = await _dio.delete(
        ApiConstants.deleteFavorite,
        data: {'productId': productId.toString()},
      );

      if (response.statusCode == 200) {
        return Success(response.data['message'] ?? 'Removed from favourites');
      }
      return Error("Failed to remove favourite: Status ${response.statusCode}");
    } on DioException catch (e) {
      return Error(_mapError(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  String _mapError(DioException e) {
    try {
      return HandleDioExceptionsService.handle(e);
    } catch (message) {
      return message.toString();
    }
  }
}