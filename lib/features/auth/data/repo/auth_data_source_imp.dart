import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/model/login_response_dto.dart';
import 'package:shopping_app/features/auth/data/model/register_dto.dart';
import 'package:shopping_app/features/auth/domain/entity/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/entity/register_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_remote_data_source_interface.dart';

@Injectable(as: AuthRemoteDataSourceInterface)
class AuthDataSourceImp implements AuthRemoteDataSourceInterface {
  final Dio _dio;
  AuthDataSourceImp(this._dio);
  @override
  Future<ResultApi<String>> register(RegisterEntity entity) async {
    var request = RegisterDto(
      name: entity.userName,
      phone: entity.phoneNumber,
      email: entity.email,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
    try {
      final response = await _dio.post(
        ApiConstants.signUp,
        data: request.toJson(),
        options: Options(headers: ApiConstants.headers),
      );
      if (response.statusCode == 200) {
        return Success<String>(response.data["message"]);
      }
      return Error<String>("Error");
    } catch (e) {
      return Error<String>(e.toString());
    }
  }

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.signIn,
        data: {"email": email, "password": password},
        options: Options(headers: ApiConstants.headers),
      );

      if (response.statusCode == 200) {
        return Success<LoginResponseEntity>(
          LoginResponseDto.fromJson(response.data).toEntity(),
        );
      }
      return Error<LoginResponseEntity>("Error");
    } catch (e) {
      return Error<LoginResponseEntity>(e.toString());
    }
  }
}
