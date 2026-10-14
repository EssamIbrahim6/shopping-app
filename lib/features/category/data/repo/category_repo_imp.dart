import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../domain/repo/category_data_source_interface.dart';
import '../../domain/repo/category_repo_interface.dart';

@Injectable(as: CategoryRepoInterface)
class CategoryRepoImp implements CategoryRepoInterface {
  final CategoryDataSourceInterface dataSource;

  CategoryRepoImp(this.dataSource);

  @override
  Future<ResultApi<List<ProductItemEntity>>> getProductsByCategory(
      String categoryName, {
        int skip = 0,
        int limit = 6,
      }) async {
    try {
      final dtos = await dataSource.getProductsByCategory(
        categoryName,
        skip: skip,
        limit: limit,
      );

      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Success(entities);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e) {
      return Error(e.toString());
    }
  }
}