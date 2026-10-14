import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class DeleteTokenUseCase {
  final AuthRepoInterface _repo;

  DeleteTokenUseCase(this._repo);

  Future<void> invoke() {
    return _repo.deleteToken();
  }
}
