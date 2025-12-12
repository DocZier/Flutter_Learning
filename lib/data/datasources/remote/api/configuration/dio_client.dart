import 'package:dio/dio.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/client.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/interceptors/error_interceptor.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/interceptors/logging_interceptor.dart';


class DioClient {
  static const String baseUrl = 'https://jlpt-vocab-api.vercel.app/';
  static const String kanjiBaseUrl = 'https://kanjiapi.dev/v1/';

  final Dio _dio;
  final Dio _kanjiDio;

  DioClient()
      : _dio = Dio(),
        _kanjiDio = Dio() {
    _setupDio(_dio, baseUrl);
    _setupDio(_kanjiDio, kanjiBaseUrl);
    _setupInterceptors();
  }

  void _setupDio(Dio dio, String baseUrl) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    _kanjiDio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Dio get dio => _dio;
  Dio get kanjiDio => _kanjiDio;
}