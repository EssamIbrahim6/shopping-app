import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/storage_helper/secure_storage_helper.dart';
import 'package:shopping_app/core/storage_helper/storage_key.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_local_data_source_interface.dart';

@Injectable(as: AuthLocalDataSourceInterface)
class AuthLocalDataSourceImp implements AuthLocalDataSourceInterface {
  final SecureStorageHelper _storage;
  AuthLocalDataSourceImp(this._storage);
  @override
  Future<void> saveToken(String token) =>
      _storage.saveSecure(key: StorageKey.userToken, value: token);
  @override
  Future<String?> getToken() => _storage.getSecure(key: StorageKey.userToken);
  @override
  Future<void> deleteToken() =>
      _storage.deleteSecure(key: StorageKey.userToken);
}
