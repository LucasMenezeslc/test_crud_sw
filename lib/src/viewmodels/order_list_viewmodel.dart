import 'package:flutter/material.dart';
import '../core/rest/api_client.dart';
import '../models/order_model.dart';

enum OrderStatusFilter { all, finished, notFinished }

class OrderListViewModel extends ChangeNotifier {
  final ApiClient _apiClient;

  OrderListViewModel(this._apiClient);

  List<OrderModel> _orders = [];
  String? _errorMessage;
  bool _isLoading = false;

  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  OrderStatusFilter get statusFilter => _statusFilter;
  DateTimeRange? get dateRange => _dateRange;

  OrderStatusFilter _statusFilter = OrderStatusFilter.all;
  DateTimeRange? _dateRange;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<OrderModel> get orders {
    List<OrderModel> filtered = _orders;

    if (_statusFilter == OrderStatusFilter.finished) {
      filtered = filtered.where((o) => o.finished).toList();
    } else if (_statusFilter == OrderStatusFilter.notFinished) {
      filtered = filtered.where((o) => !o.finished).toList();
    }

    if (_dateRange != null) {
      filtered =
          filtered
              .where(
                (o) =>
                    o.createdAt.isAfter(
                      _dateRange!.start.subtract(const Duration(seconds: 1)),
                    ) &&
                    o.createdAt.isBefore(
                      _dateRange!.end.add(const Duration(days: 1)),
                    ),
              )
              .toList();
    }
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return filtered;
  }

  int get totalOrders => _orders.length;
  int get totalFinishedOrders => _orders.where((o) => o.finished).length;
  int get totalNotFinishedOrders => _orders.where((o) => !o.finished).length;

  void setStatusFilter(OrderStatusFilter filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  void setDateRange(DateTimeRange? range) {
    _dateRange = range;
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    _errorMessage = null;
    setIsLoading(true);
    try {
      final response = await _apiClient.get('/orders');
      final List data = response.data as List;
      _orders = data.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Erro ao buscar pedidos.';
    }
    setIsLoading(false);
  }

  Future<void> completeOrder(String id) async {
    _errorMessage = null;
    try {
      await _apiClient.put('/orders/$id/finish');
      await fetchOrders();
    } catch (e) {
      _errorMessage = 'Erro ao concluir pedido.';
      notifyListeners();
    }
  }
}
