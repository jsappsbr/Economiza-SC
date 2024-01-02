import 'package:economiza_sc/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:economiza_sc/models/user.dart';
import 'package:economiza_sc/exceptions/http_exception.dart';
import 'package:economiza_sc/services/snack_bar_service.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final _authService = Modular.get<AuthService>();
  final _snackBarService = Modular.get<SnackBarService>();

  @observable
  bool isLogged = false;

  @observable
  bool isAuthenticating = false;

  @observable
  bool isFetchingCurrentUser = false;

  @observable
  User? user;

  @action
  Future<void> login(String email, String password) async {
    try {
      isAuthenticating = true;

      await Future.delayed(const Duration(seconds: 1));

      user = await _authService.login(email, password);

      isLogged = true;
      isAuthenticating = false;

      Modular.to.navigate('/');
    } on HttpException catch (e) {
      final message = e.isUnauthorized
          ? 'E-mail ou senha incorretos.'
          : 'Algo deu errado ao realizar o login. Tente novamente mais tarde.';

      _snackBarService.show(message, duration: const Duration(seconds: 3));
    } finally {
      isAuthenticating = false;
    }
  }

  @action
  fetchCurrentUser() async {
    try {
      isFetchingCurrentUser = true;

      String? token = await _authService.getApiToken();

      if (token != null && token.isNotEmpty) {
        user = await _authService.fetchCurrentUser();
        isLogged = true;
        Modular.to.navigate('/');
      }
    } catch (e) {
      debugPrint("Erro ao buscar usuário logado: $e");
    } finally {
      isFetchingCurrentUser = false;
    }
  }

  @action
  Future<void> logout() async {
    try {
      await _authService.logout();
      isLogged = false;
      user = null;
      Modular.to.navigate('/login');
    } catch (e) {
      debugPrint("Logout falhou: $e");
    }
  }
}
