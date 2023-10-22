import 'package:anotei/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../models/user.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final _authService = Modular.get<AuthService>();

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
    } catch (e) {
      debugPrint("Login falhou: $e");
    } finally {
      isAuthenticating = false;
    }
  }

  @action
  fetchCurrentUser() async {
    try {
      isFetchingCurrentUser = true;

      await Future.delayed(const Duration(seconds: 1));

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
