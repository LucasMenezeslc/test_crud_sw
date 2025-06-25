import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_crud_sw/src/core/ui/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final isAuthenticated = await authViewModel.checkAuthentication();
    if (!mounted) return;
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, AppRoutes.orderList);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.textOnPrimary,
              child: Icon(
                Icons.slow_motion_video,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.textOnPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
