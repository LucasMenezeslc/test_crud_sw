import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../env/env.dart';
import '../manager/injector.dart';
import 'oauth_manager.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient(this._dio, this._storage) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (!options.path.startsWith('http')) {
            options.baseUrl = Env.apiBaseUrl;
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final oauthManager = injector.get<OAuthManager>();
            final refreshed = await oauthManager.refreshToken();
            if (refreshed) {
              final token = await _storage.read(key: 'access_token');
              error.requestOptions.headers['Authorization'] = 'Bearer $token';
              final cloneReq = await _dio.fetch(error.requestOptions);
              return handler.resolve(cloneReq);
            } else {
              await oauthManager.logout();
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);
}
