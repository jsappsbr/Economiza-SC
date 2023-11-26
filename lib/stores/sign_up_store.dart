import 'package:economiza_sc/services/sign_up_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_store.g.dart';

class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  final _signUpService = Modular.get<SignUpService>();

  @observable
  bool isCreatingUser = false;

  @action
  Future<void> signUp(String name, String email, String password, String passwordConfirmation) async {
    try {
      isCreatingUser = true;

      await Future.delayed(const Duration(seconds: 1));
      await _signUpService.signUp(name, email, password, passwordConfirmation);

      isCreatingUser = false;
      Modular.to.navigate('/login');
    } catch (e) {
      debugPrint("Cadastro falhou: $e");
    } finally {
      isCreatingUser = false;
    }
  }
}
