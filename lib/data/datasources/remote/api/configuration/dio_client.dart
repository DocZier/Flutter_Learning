import 'package:dio/dio.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/client.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/interceptors/error_interceptor.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/interceptors/logging_interceptor.dart';

class DioClient {
  final BaseClient _baseClient;

  DioClient() : _baseClient = BaseClient(Dio()) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _baseClient.dio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    _baseClient.kanjiDio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Dio get dio => _baseClient.dio;
  Dio get kanjiDio => _baseClient.kanjiDio;
}