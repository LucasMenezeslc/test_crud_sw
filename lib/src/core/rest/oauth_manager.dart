import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../env/env.dart';

class OAuthManager {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  OAuthManager(this._dio, this._storage);

  Future<bool> hasRefreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '${Env.apiBaseUrl}/connect/token',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          'grant_type': 'password',
          'client_id': 'user',
          'scope': 'user offline_access',
          'username': username,
          'password': password,
        },
      );
      final data = response.data;
      await _storage.write(key: 'access_token', value: data['access_token']);
      await _storage.write(key: 'refresh_token', value: data['refresh_token']);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return false;
    try {
      final response = await _dio.post(
        '${Env.apiBaseUrl}/connect/token',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          'grant_type': 'refresh_token',
          'client_id': 'user',
          'refresh_token': refreshToken,
        },
      );
      final data = response.data;
      await _storage.write(key: 'access_token', value: data['access_token']);
      await _storage.write(key: 'refresh_token', value: data['refresh_token']);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
