// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_crud_sw/src/core/ui/custom/custom_button.dart';
import 'package:test_crud_sw/src/core/ui/custom/custom_text_form_field.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
        listenable: authViewModel,
        builder:
            (context, child) => Stack(
              children: [
                Container(height: 0.5 * size.height, color: AppColors.primary),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Teste SwFast - Lucas Menezes',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 0.5,
                        color: AppColors.background,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            spacing: 20,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50),
                              Text('Login'),
                              CustomTextFormField(
                                labelText: 'Usuário',
                                controller: _userController,
                              ),
                              CustomTextFormField(
                                labelText: 'Senha',
                                controller: _passController,
                              ),
                              CustomButton(
                                loading: authViewModel.isLoading,
                                height: 0.06 * size.height,
                                width: size.width,
                                onPressed: () async {
                                  final success = await authViewModel.login(
                                    context,
                                    _userController.text,
                                    _passController.text,
                                  );
                                  if (!success && mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Usuário ou senha inválidos.',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                title: 'Entrar',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 350),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.background,
                      child: Icon(
                        Icons.slow_motion_video,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
