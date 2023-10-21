import 'package:anotei/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _authStore = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    _authStore.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Anotei',
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
