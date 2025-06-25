import 'package:flutter/material.dart';
import '../../views/login/login_screen.dart';
import '../../views/orders/order_list_screen.dart';
import '../../views/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String orderList = '/orderList';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => SplashScreen(),
    login: (_) => LoginScreen(),
    orderList: (_) => const OrderListScreen(),
  };

  static String get initialRoute => splash;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case orderList:
        return MaterialPageRoute(builder: (_) => const OrderListScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
