import 'package:dio/dio.dart';

class BaseClient {
  static const _baseUrl = 'https://jlpt-vocab-api.vercel.app/';
  static const _kanjiBaseUrl = 'https://kanjiapi.dev/v1/';

  final Dio _dio;

  BaseClient(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Dio get dio => _dio;

  Dio get kanjiDio {
    final kanjiDio = Dio();
    kanjiDio.options.baseUrl = _kanjiBaseUrl;
    kanjiDio.options.connectTimeout = const Duration(seconds: 30);
    kanjiDio.options.receiveTimeout = const Duration(seconds: 30);
    kanjiDio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return kanjiDio;
  }
}