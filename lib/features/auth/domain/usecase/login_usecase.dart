import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entity/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class LoginUsecase {
  LoginUsecase(this._repo);
  final AuthRepoInterface _repo;
  Future<ResultApi<LoginResponseEntity>> invoke({
    required String email,
    required String password,
  }) async {
    return await _repo.login(email: email, password: password);
  }
}
