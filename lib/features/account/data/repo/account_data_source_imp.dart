import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/features/account/data/models/user_profile_model.dart';

abstract class AccountRemoteDataSource {
  Future<UserProfileModel> getUserData();

  Future<String> uploadImage(String imagePath);

  Future<void> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imageUrl,
  });
}

@LazySingleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final Dio _dio;

  AccountRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfileModel> getUserData() async {
    try {
      final response = await _dio.get(ApiConstants.userData);
      return UserProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      HandleDioExceptionsService.handle(e);
      rethrow;
    }
  }

  @override
  Future<String> uploadImage(String imagePath) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.post(ApiConstants.addImage, data: formData);
      return response.data['image'] ?? response.data['message'] ?? '';
    } on DioException catch (e) {
      HandleDioExceptionsService.handle(e);
      rethrow;
    }
  }

  @override
  Future<void> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imageUrl,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'phone': phone,
        'address': address,
      };

      if (imageUrl != null && imageUrl.isNotEmpty) {
        data['image'] = imageUrl;
      }

      await _dio.post(ApiConstants.editUserData, data: data);
    } on DioException catch (e) {
      HandleDioExceptionsService.handle(e);
      rethrow;
    }
  }
}
