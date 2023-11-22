import 'package:economiza_sc/stores/auth_store.dart';
import 'package:economiza_sc/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    return Observer(builder: (_) {
      if (_authStore.isFetchingCurrentUser) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.red),
          ),
        );
      }

      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        title: 'Economiza SC',
        routerConfig: Modular.routerConfig,
      );
    });
  }
}
