import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entity/register_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class RegisterUseCase {
  RegisterUseCase(this._repo);
  final AuthRepoInterface _repo;

  Future<ResultApi<String>> invoke(RegisterEntity entity) async {
    return await _repo.register(entity);
  }
}
