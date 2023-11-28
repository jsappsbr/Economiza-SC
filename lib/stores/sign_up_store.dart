import 'package:economiza_sc/services/sign_up_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_store.g.dart';

class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  final _signUpService = Modular.get<SignUpService>();

  @observable
  bool isLoading = false;

  @observable
  bool isPasswordVisible = false;

  @observable
  bool isPasswordConfirmationVisible = false;


  @action
  Future<void> signUp(String name, String email, String password, String passwordConfirmation) async {
    try {
      isLoading = true;
      await _signUpService.signUp(name, email, password, passwordConfirmation);

      isLoading = false;
      Modular.to.navigate('/login');
    } catch (e) {
      debugPrint("Cadastro falhou: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  void changePasswordVisibility() => isPasswordVisible == false ? isPasswordVisible = true : isPasswordVisible = false;

    @action
  void changePasswordConfirmationVisibility() => isPasswordConfirmationVisible == false ? isPasswordConfirmationVisible = true : isPasswordConfirmationVisible = false;
}