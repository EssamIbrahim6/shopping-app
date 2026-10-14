import 'package:dio/dio.dart';

abstract final class HandleDioExceptionsService {
  static String handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';

      case DioExceptionType.sendTimeout:
        return 'Send timeout';

      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';

      case DioExceptionType.badCertificate:
        return 'Bad SSL certificate';

      case DioExceptionType.cancel:
        return 'Request cancelled';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.unknown:
        return e.message ?? 'Unknown error';

      case DioExceptionType.transformTimeout:
        return 'Request processing timed out';

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response);
    }
  }

  static String _handleStatusCode(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return 'Bad request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Forbidden';

      case 404:
        return 'Resource not found';

      case 409:
        return 'Conflict';

      case 422:
        return 'Validation failed';

      case 500:
        return 'Internal server error';

      case 502:
        return 'Bad gateway';

      case 503:
        return 'Service unavailable';

      case 504:
        return 'Gateway timeout';

      default:
        return response?.statusMessage ?? 'Something went wrong';
    }
  }
}
