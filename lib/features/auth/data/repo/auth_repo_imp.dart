import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entity/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/entity/register_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_local_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_remote_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImp implements AuthRepoInterface {
  final AuthRemoteDataSourceInterface remote;

  final AuthLocalDataSourceInterface local;

  AuthRepoImp(this.remote, this.local);

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await remote.login(email: email, password: password);

    if (result is Success<LoginResponseEntity>) {
      final token = result.data.token;

      debugPrint("API TOKEN = $token");

      if (token.isNotEmpty) {
        await local.saveToken(token);

        final saved = await local.getToken();
        debugPrint("SAVED TOKEN = $saved");
      } else {
        debugPrint("TOKEN IS EMPTY");
      }
    }

    return result;
  }

  @override
  Future<ResultApi<String>> register(RegisterEntity entity) {
    return remote.register(entity);
  }

  @override
  Future<String?> getToken() {
    return local.getToken();
  }

  @override
  Future<void> deleteToken() {
    return local.deleteToken();
  }
}
