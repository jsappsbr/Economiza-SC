import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:anotei/modules/app_module.dart';

void main() {
  // Modular.setInitialRoute('/login');
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Basic App',
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
