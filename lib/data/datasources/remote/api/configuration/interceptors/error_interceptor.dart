import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final dynamic data;

  NetworkException(this.message, {this.data});

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException extends NetworkException {
  TimeoutException(String message) : super(message);
}

class BadRequestException extends NetworkException {
  BadRequestException(String message, {dynamic data}) : super(message, data: data);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException(String message) : super(message);
}

class ServerException extends NetworkException {
  ServerException(String message, {dynamic data}) : super(message, data: data);
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    NetworkException networkException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        networkException = TimeoutException('Request timed out');
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;

        if (statusCode == 400) {
          networkException = BadRequestException('Bad request', data: data);
        } else if (statusCode == 401) {
          networkException = UnauthorizedException('Unauthorized');
        } else if (statusCode != null && statusCode >= 500) {
          networkException = ServerException('Server error', data: data);
        } else {
          networkException = NetworkException('Unknown error', data: data);
        }
        break;
      default:
        networkException = NetworkException('Network error', data: err.message);
    }

    handler.reject(err);
  }
}