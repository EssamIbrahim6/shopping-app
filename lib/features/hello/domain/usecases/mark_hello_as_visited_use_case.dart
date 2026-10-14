import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/hello/domain/repo/hello_repo_interface.dart';

@injectable
class MarkHelloAsVisitedUseCase {
  const MarkHelloAsVisitedUseCase(this._repo);
  final HelloRepoInterface _repo;

  Future<void> invoke() => _repo.markHelloAsVisited();
}
