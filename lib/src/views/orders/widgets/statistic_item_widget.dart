// ignore_for_file: unused_element_parameter, unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';

class StatisticItemWidget extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;
  final bool highlight;

  const StatisticItemWidget({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                highlight
                    ? AppColors.textOnPrimary.withOpacity(0.15)
                    : Colors.transparent,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: highlight ? 28 : 20,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
