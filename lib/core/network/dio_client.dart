import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;
  DioClient()
      : _dio = Dio(
          BaseOptions(
              baseUrl: _getBaseUrl(),
              connectTimeout: Duration(seconds: 10),
              receiveTimeout: Duration(seconds: 10),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": _getApiKey(),
              },
              validateStatus: (status) {
                return status != null && status < 500;
              }),
        );
  static String _getBaseUrl() {
    return 'http://192.168.0.101:8000/';
  }

  static String _getApiKey() {
    return 'GS_API_KEY';
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(Object error) {
    print("DioError: $error");
  }
}
