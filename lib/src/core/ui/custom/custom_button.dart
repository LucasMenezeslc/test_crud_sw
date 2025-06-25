// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback onPressed;
  bool? loading;

  CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          elevation: WidgetStatePropertyAll(0.5),
          backgroundColor: WidgetStatePropertyAll(AppColors.primary),
        ),
        onPressed: onPressed,
        child:
            loading ?? false
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round,
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    backgroundColor: AppColors.textOnPrimary,
                  ),
                )
                : Text(title, style: TextStyle(color: AppColors.textOnPrimary)),
      ),
    );
  }
}
