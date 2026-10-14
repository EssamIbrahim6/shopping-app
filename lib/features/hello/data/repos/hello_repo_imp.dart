import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/hello/domain/repo/hello_data_source_interface.dart';
import 'package:shopping_app/features/hello/domain/repo/hello_repo_interface.dart';

@Injectable(as: HelloRepoInterface)
class HelloRepoImp implements HelloRepoInterface {
  const HelloRepoImp(this._dataSource);
  final HelloDataSourceInterface _dataSource;

  @override
  bool hasVisitedHello() => _dataSource.hasVisitedHello();

  @override
  Future<void> markHelloAsVisited() => _dataSource.markHelloAsVisited();
}
