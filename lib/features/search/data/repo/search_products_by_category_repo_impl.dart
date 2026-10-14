import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/search/domain/repo/search_products_by_category_data_source_interface.dart';
import 'package:shopping_app/features/search/domain/repo/search_products_by_category_repo_interface.dart';

@LazySingleton(as: SearchProductsByCategoryRepoInterface)
class SearchProductsByCategoryRepoImpl
    implements SearchProductsByCategoryRepoInterface {
  const SearchProductsByCategoryRepoImpl(this._dataSource);
  final SearchProductsByCategoryDataSourceInterface _dataSource;

  @override
  Future<ResultApi<List<ProductItemEntity>>> searchProductsByCategory(
    body,
  ) async {
    try {
      final dataDto = await _dataSource.searchProductsByCategory(body);
      final dataEntities = dataDto.map((e) => e.toEntity()).toList();
      return Success(dataEntities);
    } on DioException catch (e) {
      final String error = HandleDioExceptionsService.handle(e);
      return Error(error.toString());
    } catch (error) {
      return Error(error.toString());
    }
  }
}
