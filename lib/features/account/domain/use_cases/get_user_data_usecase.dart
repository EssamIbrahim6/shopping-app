import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@injectable
class GetUserDataUseCase {
  final AccountRepoInterface _repository;

  GetUserDataUseCase(this._repository);

  Future<ResultApi<UserEntity>> call() async {
    return await _repository.getUserData();
  }
}
