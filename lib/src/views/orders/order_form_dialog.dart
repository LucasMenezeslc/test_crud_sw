// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_crud_sw/src/core/ui/custom/custom_button.dart';
import 'package:test_crud_sw/src/core/ui/custom/custom_text_form_field.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';
import '../../viewmodels/order_form_viewmodel.dart';

class OrderFormDialog extends StatefulWidget {
  const OrderFormDialog({super.key});

  @override
  State<OrderFormDialog> createState() => _OrderFormDialogState();
}

class _OrderFormDialogState extends State<OrderFormDialog> {
  late final TextEditingController _descController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _descController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrderFormViewModel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(viewModel.errorMessage!)));
      }
    });
    return AlertDialog.adaptive(
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              labelText: 'Descrição',
              controller: _descController,
              focusNode: _focusNode,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
                CustomButton(
                  title: 'Adicionar',
                  loading: viewModel.isLoading,
                  onPressed: () async {
                    await viewModel.addOrder(_descController.text);
                    if (viewModel.errorMessage == null) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
