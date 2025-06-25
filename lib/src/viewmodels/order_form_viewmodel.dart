import 'package:flutter/material.dart';
import '../core/rest/api_client.dart';

class OrderFormViewModel extends ChangeNotifier {
  final ApiClient _apiClient;
  bool _isLoading = false;
  String? _errorMessage;

  OrderFormViewModel(this._apiClient);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addOrder(String description) async {
    _errorMessage = null;
    setIsLoading(true);
    try {
      await _apiClient.post('/orders', data: {'description': description});
    } catch (e) {
      _errorMessage = 'Erro ao adicionar pedido.';
    }
    setIsLoading(false);
  }
}
