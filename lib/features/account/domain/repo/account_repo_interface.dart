import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';

abstract class AccountRepoInterface {
  Future<ResultApi<UserEntity>> getUserData();

  Future<ResultApi<void>> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imagePath,
  });
}
