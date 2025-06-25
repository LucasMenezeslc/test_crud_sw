import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_crud_sw/src/core/manager/injector.dart';

import '../../../main.dart';

class AppInitialization {
  AppInitialization();

  Future<void> execute() async {
    await initializeDateFormatting('pt_BR', null);
    setupInjector();

    runApp(const AppWidget());
  }
}
