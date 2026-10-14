import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class RemoveFavouriteUseCase {
  final FavouriteRepoInterface _favouriteRepoInterface;
  RemoveFavouriteUseCase(this._favouriteRepoInterface);

  Future<ResultApi<String>> invoke(int productId) async =>
      await _favouriteRepoInterface.removeFavourite(productId);
}