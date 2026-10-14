import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/data/repo/account_data_source_imp.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@LazySingleton(as: AccountRepoInterface)
class AccountRepoImpl implements AccountRepoInterface {
  final AccountRemoteDataSource _remoteDataSource;

  AccountRepoImpl(this._remoteDataSource);

  @override
  Future<ResultApi<UserEntity>> getUserData() async {
    try {
      final model = await _remoteDataSource.getUserData();

      return Success<UserEntity>(
        UserEntity(
          id: model.id,
          name: model.name,
          phone: model.phone,
          email: model.email,
          address: model.address,
          image: model.image,
        ),
      );
    } catch (e) {
      return Error<UserEntity>(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imagePath,
  }) async {
    try {
      String? imageUrl;

      if (imagePath != null && imagePath.isNotEmpty) {
        imageUrl = await _remoteDataSource.uploadImage(imagePath);
      }

      await _remoteDataSource.editUserData(
        name: name,
        phone: phone,
        address: address,
        imageUrl: imageUrl,
      );

      return Success<void>(null);
    } catch (e) {
      return Error<void>(e.toString());
    }
  }
}
