// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../core/rest/oauth_manager.dart';
import '../core/routes/app_routes.dart';

class AuthViewModel extends ChangeNotifier {
  final OAuthManager _oauthManager;
  bool _isAuthenticated = false;

  AuthViewModel(this._oauthManager);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isAuthenticated => _isAuthenticated;

  void setIsAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  Future<bool> checkAuthentication() async {
    setIsLoading(true);
    try {
      final hasToken = await _oauthManager.hasRefreshToken();
      if (!hasToken) {
        setIsAuthenticated(false);
        return false;
      }
      final success = await _oauthManager.refreshToken();
      setIsAuthenticated(success);
      return success;
    } catch (e) {
      setIsAuthenticated(false);
      return false;
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> initializeAuth() async {
    await checkAuthentication();
  }

  Future<bool> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    setIsLoading(true);
    _isAuthenticated = await _oauthManager.login(username, password);
    setIsLoading(false);

    if (_isAuthenticated) {
      Navigator.pushReplacementNamed(context, AppRoutes.orderList);
    }

    return _isAuthenticated;
  }

  Future<void> logout() async {
    await _oauthManager.logout();
    setIsAuthenticated(false);
  }
}
