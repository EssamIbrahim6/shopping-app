import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import '../../domain/repo/category_data_source_interface.dart';

@Injectable(as: CategoryDataSourceInterface)
class CategoryDataSourceImp implements CategoryDataSourceInterface {
  final Dio dio;

  CategoryDataSourceImp(this.dio);

  @override
  Future<List<ProductItemDto>> getProductsByCategory(
      String categoryName, {
        int skip = 0,
        int limit = 6,
      }) async {
    final response = await dio.get(
      ApiConstants.productByCategory(categoryName),
      queryParameters: {'skip': skip, 'limit': limit},
    );

    final List<dynamic> dynamicList = response.data is Map
        ? (response.data['list'] ?? [])
        : [];

    return dynamicList
        .map((item) => ProductItemDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}