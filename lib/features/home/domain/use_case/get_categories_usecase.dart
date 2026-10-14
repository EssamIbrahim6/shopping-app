import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetCategoriesUseCase {
  final HomeRepoInterface _homeRepoInterface;
  GetCategoriesUseCase(this._homeRepoInterface);

  Future<ResultApi<List<CategoryEntity>>> invoke() async =>
      await _homeRepoInterface.getCategories();
}
