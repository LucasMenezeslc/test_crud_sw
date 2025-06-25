import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/manager/app_initialization.dart';
import 'src/core/manager/injector.dart';
import 'src/core/routes/app_routes.dart';
import 'src/viewmodels/auth_viewmodel.dart';
import 'src/viewmodels/order_form_viewmodel.dart';
import 'src/viewmodels/order_list_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitialization().execute();
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(injector.get())),
        ChangeNotifierProvider(
          create: (_) => OrderListViewModel(injector.get()),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderFormViewModel(injector.get()),
        ),
      ],
      child: MaterialApp(
        title: 'CRUD Sw',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
