import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_crud_sw/src/views/orders/widgets/card_statistics_widget.dart';
import '../../core/ui/app_colors.dart';
import '../../viewmodels/order_list_viewmodel.dart';
import 'widgets/order_tile.dart';
import 'order_form_dialog.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderListViewModel>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrderListViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(viewModel.errorMessage!)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          PopupMenuButton<OrderStatusFilter>(
            icon: const Icon(Icons.filter_list),
            onSelected: (filter) => viewModel.setStatusFilter(filter),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: OrderStatusFilter.all,
                    child: Text('Todos'),
                  ),
                  PopupMenuItem(
                    value: OrderStatusFilter.finished,
                    child: Text('Finalizados'),
                  ),
                  PopupMenuItem(
                    value: OrderStatusFilter.notFinished,
                    child: Text('Não finalizados'),
                  ),
                ],
          ),
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDateRange: viewModel.dateRange,
              );
              viewModel.setDateRange(picked);
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return viewModel.isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Column(
                children: [
                  CardStatisticsWidget(
                    total: viewModel.totalOrders,
                    totalFinished: viewModel.totalFinishedOrders,
                    totalNotFinished: viewModel.totalNotFinishedOrders,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => viewModel.fetchOrders(),
                      child:
                          viewModel.orders.isEmpty
                              ? Center(
                                child: Column(
                                  spacing: 20,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        245,
                                        243,
                                        243,
                                      ),
                                      child: Icon(
                                        size: 40,
                                        Icons.lightbulb_sharp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      'Sem pedidos criados\n'
                                      'no momento!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                              : ListView.builder(
                                itemCount: viewModel.orders.length,
                                itemBuilder: (context, index) {
                                  final order = viewModel.orders[index];
                                  return OrderTile(
                                    order: order,
                                    onComplete:
                                        () => viewModel.completeOrder(order.id),
                                  );
                                },
                              ),
                    ),
                  ),
                ],
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.5,
        backgroundColor: AppColors.primary,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (contextDialog) => OrderFormDialog(),
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            viewModel.fetchOrders();
          });
        },
        child: const Icon(Icons.add, color: AppColors.textOnPrimary),
      ),
    );
  }
}
