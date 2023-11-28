// ignore_for_file: use_build_context_synchronously

import 'package:economiza_sc/services/sign_up_service.dart';
import 'package:economiza_sc/widgets/exception_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_store.g.dart';

class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  final _signUpService = Modular.get<SignUpService>();
  final exceptionSnackBar = ExceptionSnackBar();

  @observable
  bool isLoading = false;

  @observable
  bool isPasswordObscure = true;

  @observable
  bool isPasswordConfirmationObscure = true;

  @observable
  bool signUpSuccess = false;

  @action
  Future<void> signUp(String name, String email, String password, String passwordConfirmation, BuildContext context) async {
    try {
      isLoading = true;
      await _signUpService.signUp(name, email, password, passwordConfirmation);

      signUpSuccess = true;
      Modular.to.navigate('/login');
    } on FormValidationError {
      exceptionSnackBar.displaySnackBar('Houve um erro na validação do formulário', context);
    } on AccountAlreadyExistent {
      exceptionSnackBar.displaySnackBar('Esse email já está cadastrado', context);
    } on TooManyRequests {
      exceptionSnackBar.displaySnackBar('Faça apenas uma tentativa de cadastro por vez', context);
    } on UnknownError {
      exceptionSnackBar.displaySnackBar('Houve um erro desconhecido, entre em contato com o suporte', context);
    } finally {
      isLoading = false;
    }
  }

  @action
  void changePasswordVisibility() => isPasswordObscure == true ? isPasswordObscure = false : isPasswordObscure = true;

  @action
  void changePasswordConfirmationVisibility() =>
      isPasswordConfirmationObscure == true ? isPasswordConfirmationObscure = false : isPasswordConfirmationObscure = true;
}
