import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/pagination_query_params.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_dto.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';

@LazySingleton(as: HomeDataSourceInterface)
class HomeDataSourceRemoteImpl implements HomeDataSourceInterface {
  final Dio _dio;

  HomeDataSourceRemoteImpl(this._dio);

  @override
  Future<ResultApi<CategoriesDto>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.allCategories);
      var categories = CategoriesDto.fromJson(response.data);
      return Success(categories);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<List<ProductItemDto>>> getProducts({
    required int page,
  }) async {
    try {
      final skip = (page - 1) * ApiConstants.pageLimit;

      log('Page: $page');
      log('Skip: $skip');
      log('Limit: ${ApiConstants.pageLimit}');

      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.allProducts,
        queryParameters: PaginationQueryParams(
          skip: skip,
          limit: ApiConstants.pageLimit,
        ).toJson(),
      );

      if (response.statusCode != 200) {
        return Error(
          'Failed to load products. Status code: ${response.statusCode}',
        );
      }

      final List<dynamic> data = response.data?['list'] as List<dynamic>? ?? [];

      final products = data
          .map((json) => ProductItemDto.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(products);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e, stackTrace) {
      log('Get Products Error', error: e, stackTrace: stackTrace);
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<ProductItemDto>> getProductById({required int productId}) async {
    try {
      final response = await _dio.get(
        ApiConstants.productDetails(productId.toString()),
      );

      if (response.statusCode != 200) {
        return Error(
          'Failed to load product. Status code: ${response.statusCode}',
        );
      }

      final product = ProductItemDto.fromJson(response.data!);

      return Success(product);
    } on DioException catch (e) {
      return Error(HandleDioExceptionsService.handle(e));
    } catch (e, stackTrace) {
      log(
        'Get Product By Id Error',
        error: e,
        stackTrace: stackTrace,
      );
      return Error(e.toString());
    }
  }
}