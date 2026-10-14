import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';
import 'package:shopping_app/core/storage_helper/storage_key.dart';
import 'package:shopping_app/features/hello/domain/repo/hello_data_source_interface.dart';

@Injectable(as: HelloDataSourceInterface)
class HelloDataSourceImp implements HelloDataSourceInterface {
  @override
  bool hasVisitedHello() {
    return SharedPref.getBool(StorageKey.hasVisitedHello);
  }

  @override
  Future<void> markHelloAsVisited() {
    return SharedPref.saveBool(StorageKey.hasVisitedHello, true);
  }
}
