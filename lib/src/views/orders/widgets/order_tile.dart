import 'package:flutter/material.dart';
import 'package:test_crud_sw/src/core/utils/date_utils.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';
import '../../../models/order_model.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onComplete;

  const OrderTile({super.key, required this.order, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final String status = order.finished ? 'Finalizado' : 'Não finalizado';
    final Color statusColor =
        order.finished ? AppColors.finished : AppColors.pending;

    return Row(
      children: [
        Container(
          width: 6,
          height: 56,
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              order.description,
              style: TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Criado em: ${order.createdAt.toDatePtbr()}'),
                Text('Status: $status'),
              ],
            ),
            trailing:
                order.finished
                    ? Icon(
                      Icons.check_circle,
                      color: AppColors.finished,
                      size: 30,
                    )
                    : IconButton(
                      icon: const Icon(Icons.circle_outlined),
                      color: AppColors.cardShadow,
                      onPressed: onComplete,
                    ),
          ),
        ),
      ],
    );
  }
}
