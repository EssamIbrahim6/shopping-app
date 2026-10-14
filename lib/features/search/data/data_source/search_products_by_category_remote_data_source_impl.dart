import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/domain/repo/search_products_by_category_data_source_interface.dart';
import 'package:shopping_app/core/network/api_constants.dart';

@LazySingleton(as: SearchProductsByCategoryDataSourceInterface)
class SearchProductsByCategoryRemoteDataSourceImpl
    implements SearchProductsByCategoryDataSourceInterface {
  const SearchProductsByCategoryRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<ProductItemDto>> searchProductsByCategory(
    SearchProductsByCategoryRequestBody body,
  ) async {
    final response = await _dio.post(
      ApiConstants.searchProduct,
      data: body.toJson(),
    );
    final List dynamicList = response.data is Map
        ? (response.data['list'] ?? [])
        : [];
    final products = dynamicList
        .map((e) => ProductItemDto.fromJson(e))
        .toList();
    return products;
  }
}
