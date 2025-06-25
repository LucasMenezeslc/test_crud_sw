import 'package:flutter/material.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';

import 'statistic_item_widget.dart';

class CardStatisticsWidget extends StatelessWidget {
  final int total;
  final int totalFinished;
  final int totalNotFinished;

  const CardStatisticsWidget({
    super.key,
    required this.total,
    required this.totalFinished,
    required this.totalNotFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatisticItemWidget(
                label: 'Total',
                value: total,
                color: AppColors.textOnPrimary,
                icon: Icons.list_alt,
                highlight: true,
              ),
              StatisticItemWidget(
                label: 'Finalizados',
                value: totalFinished,
                color: AppColors.finished,
                icon: Icons.check_circle_outline,
              ),
              StatisticItemWidget(
                label: 'Pendentes',
                value: totalNotFinished,
                color: AppColors.pending,
                icon: Icons.pending_actions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
