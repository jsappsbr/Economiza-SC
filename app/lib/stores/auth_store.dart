import 'package:anotei/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../models/user.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  bool isLogged = false;

  @observable
  bool isLoading = true;

  @observable
  User? user;

  @action
  Future<void> login(String email, String password) async {
    try {
      isLoading = true;

      user = await AuthService().login(email, password);
      print(user!.toMap().toString());

      isLogged = true;
      isLoading = false;

      Modular.to.navigate('/');
    } catch (e) {
      print("Login falhou: $e");
      isLoading = false;
    }
  }
}
