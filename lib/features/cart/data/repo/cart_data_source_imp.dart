import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/features/cart/data/models/cart_model.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio _dio;

  CartRemoteDataSourceImpl(this._dio);

  @override
  Future<List<CartModel>> getCart() async {
    final response = await _dio.get(ApiConstants.getCart);

    final List data = response.data['list'] ?? [];
    return data.map((json) => CartModel.fromJson(json)).toList();
  }

  @override
  Future<void> addToCart({required String productId}) async {
    await _dio.post(
      ApiConstants.addCart,
      data: {'productId': productId.toString()},
      options: Options(contentType: Headers.jsonContentType),
    );
  }

  @override
  Future<void> deleteCartItem({required String productId}) async {
    await _dio.delete(
      ApiConstants.deleteCart,
      data: {'productId': productId.toString()},
      options: Options(contentType: Headers.jsonContentType),
    );
  }
}
