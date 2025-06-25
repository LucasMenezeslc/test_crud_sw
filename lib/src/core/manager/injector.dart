import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../rest/api_client.dart';
import '../rest/oauth_manager.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.addSingleton<Dio>(() {
    final dio = Dio();
    return dio;
  });

  injector.addSingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  injector.addSingleton<OAuthManager>(
    () =>
        OAuthManager(injector.get<Dio>(), injector.get<FlutterSecureStorage>()),
  );

  injector.addSingleton<ApiClient>(
    () => ApiClient(injector.get<Dio>(), injector.get<FlutterSecureStorage>()),
  );

  injector.commit();
}
