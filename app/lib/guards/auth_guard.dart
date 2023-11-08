import 'package:flutter_modular/flutter_modular.dart';

import 'package:economiza_sc/stores/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  bool canActivate(String path, ModularRoute route) {
    final store = Modular.get<AuthStore>();
    return store.isLogged;
  }
}
