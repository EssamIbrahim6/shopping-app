import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entity/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/entity/register_entity.dart';

abstract interface class AuthRepoInterface {
  Future<ResultApi<String>> register(RegisterEntity entity);
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  Future<String?> getToken();
  Future<void> deleteToken();
}
