import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/storage_helper/secure_storage_helper.dart';
import 'package:shopping_app/core/storage_helper/storage_key.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio provideDio(SecureStorageHelper secureStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.getSecure(
            key: StorageKey.userToken,
          );

          debugPrint("TOKEN => $token");

          options.headers["Authorization"] = "Bearer $token";

          debugPrint("HEADERS => ${options.headers}");

          // if (token != null && token.isNotEmpty) {
          //   options.headers["Authorization"] = "Bearer $token";
          // }
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      ),
    );

    return dio;
  }
}
