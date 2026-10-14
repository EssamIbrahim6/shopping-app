import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_dto.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_dto.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@LazySingleton(as: HomeRepoInterface)
class HomeRepoImpl implements HomeRepoInterface {
  final HomeDataSourceInterface _homeDataSource;

  HomeRepoImpl(this._homeDataSource);

  @override
  Future<ResultApi<List<CategoryEntity>>> getCategories() async {
    final result = await _homeDataSource.getCategories();

    switch (result) {
      case Success<CategoriesDto>():
        return Success(
          result.data.list?.map((e) => e.toEntity()).toList() ?? [],
        );

      case Error<CategoriesDto>():
        return Error(result.messageError);
    }
  }

  @override
  Future<ResultApi<List<ProductItemEntity>>> getProducts({
    required int page,
  }) async {
    final result = await _homeDataSource.getProducts(page: page);

    switch (result) {
      case Success<List<ProductItemDto>>():
        return Success(result.data.map((e) => e.toEntity()).toList());

      case Error<List<ProductItemDto>>():
        return Error(result.messageError);
    }
  }
  
  @override
  Future<ResultApi<ProductItemEntity>> getProductById({required int productId}) async {
     final result = await _homeDataSource.getProductById(productId: productId);

    switch (result) {
      case Success<ProductItemDto>():
        return Success(result.data.toEntity());

      case Error<ProductItemDto>():
        return Error(result.messageError);
    }
  }
}
