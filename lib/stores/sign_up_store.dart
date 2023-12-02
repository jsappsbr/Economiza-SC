import 'package:economiza_sc/services/sign_up_service.dart';
import 'package:economiza_sc/widgets/app_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:economiza_sc/exceptions/http_exception.dart';

part 'sign_up_store.g.dart';

class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  final scaffoldKey = GlobalKey();
  final _signUpService = Modular.get<SignUpService>();

  @observable
  bool isLoading = false;

  @observable
  bool isPasswordObscure = true;

  @observable
  bool isPasswordConfirmationObscure = true;

  @observable
  bool signUpSuccess = false;

  @action
  Future<void> signUp(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      isLoading = true;

      await _signUpService.signUp(name, email, password, passwordConfirmation);

      await AppSnackBar.show(
        scaffoldKey.currentContext!,
        const Text('Cadastro realizado. Faça login para continuar.'),
        duration: const Duration(seconds: 2),
      );

      Modular.to.navigate('/login?email=$email');
    } on HttpException catch (e) {
      String message;

      if (e.isFound) {
        message = 'E-mail já cadastrado.';
      } else if (e.isUnprocessableEntity) {
        message = "Campos inválidos.";
      } else if (e.isInternalServerError) {
        message = 'Erro interno do servidor.';
      } else {
        message =
            'Algo deu errado ao realizar o cadastro. Tente novamente mais tarde.';
      }

      AppSnackBar.show(
        scaffoldKey.currentContext!,
        Text(message),
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading = false;
    }
  }

  @action
  void changePasswordVisibility() => isPasswordObscure == true
      ? isPasswordObscure = false
      : isPasswordObscure = true;

  @action
  void changePasswordConfirmationVisibility() =>
      isPasswordConfirmationObscure == true
          ? isPasswordConfirmationObscure = false
          : isPasswordConfirmationObscure = true;
}
