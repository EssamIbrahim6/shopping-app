import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/hello/domain/repo/hello_repo_interface.dart';

@injectable
class HasVisitedHelloUseCase {
  const HasVisitedHelloUseCase(this._repo);
  final HelloRepoInterface _repo;

  bool invoke() => _repo.hasVisitedHello();
}
