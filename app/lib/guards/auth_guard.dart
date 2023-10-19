import 'package:flutter_modular/flutter_modular.dart';

import 'package:anotei/stores/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  bool canActivate(String path, ModularRoute router) {
    final store = Modular.get<AuthStore>();
    return store.isLogged;
  }
}
