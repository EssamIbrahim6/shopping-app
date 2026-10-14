import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class GetTokenUseCase {
  final AuthRepoInterface _repo;

  GetTokenUseCase(this._repo);

  Future<String?> invoke() {
    return _repo.getToken();
  }
}
