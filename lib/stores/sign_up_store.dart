import 'package:economiza_sc/services/sign_up_service.dart';
import 'package:economiza_sc/services/snack_bar_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:economiza_sc/exceptions/http_exception.dart';

part 'sign_up_store.g.dart';

class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  final _signUpService = Modular.get<SignUpService>();
  final _snackBarService = Modular.get<SnackBarService>();

  @observable
  bool isLoading = false;

  @observable
  bool isPasswordObscure = true;

  @observable
  bool isPasswordConfirmationObscure = true;

  @action
  Future<void> signUp(String name, String email, String password) async {
    try {
      isLoading = true;

      await _signUpService.signUp(name, email, password);
      await _snackBarService.show(
        'Cadastro realizado. Faça login para continuar.',
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

      _snackBarService.show(message, duration: Duration(seconds: 3));
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
