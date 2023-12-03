import 'package:economiza_sc/exceptions/http_exception.dart';
import 'package:economiza_sc/modules/core_module.dart';
import 'package:economiza_sc/modules/sign_up_module.dart';
import 'package:economiza_sc/services/sign_up_service.dart';
import 'package:economiza_sc/stores/sign_up_store.dart';
import 'package:economiza_sc/services/snack_bar_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<SignUpService>(),
  MockSpec<SnackBarService>(),
  MockSpec<IModularNavigator>()
])
import 'sign_up_store_test.mocks.dart';

void main() {
  group('#changePasswordVisibility', () {
    test('it toggles the password visibility', () {
      // TODO: implement
    });
  });

  group('#changePasswordConfirmationVisibility', () {
    test('it toggles the password confirmation visibility', () {
      // TODO: implement
    });
  });

  group('#signUp', () {
    const name = 'Test';
    const email = 'test@test.com';
    const password = 'password';

    final mockSignUpService = MockSignUpService();
    final mockSnackBarService = MockSnackBarService();
    final mockNavigator = MockIModularNavigator();

    runFailingAction(HttpException exception) async {
      final signUpStore = Modular.get<SignUpStore>();

      when(mockSignUpService.signUp(name, email, password))
          .thenThrow(exception);

      await signUpStore.signUp(name, email, password);

      expect(signUpStore.isLoading, false);
    }

    setUp(() {
      reset(mockSignUpService);
      reset(mockSnackBarService);
      reset(mockNavigator);

      Modular.navigatorDelegate = mockNavigator;

      Modular.init(CoreModule());

      // We need to bind the SignUpModule because the SignUpStore
      // depends on the SignUpService which is provided by the SignUpModule.
      // Binding the module this will setup the dependency injection, which
      // will allow us to replace the SignUpService instance with a mock.
      Modular.bindModule(SignUpModule());

      Modular.replaceInstance<SignUpService>(mockSignUpService);
      Modular.replaceInstance<SnackBarService>(mockSnackBarService);
    });

    tearDown(() {
      Modular.destroy();
    });

    group('when the sign up succeeds', () {
      setUp(() async {
        final signUpStore = Modular.get<SignUpStore>();

        expect(signUpStore.isLoading, false);

        await signUpStore.signUp(name, email, password);

        expect(signUpStore.isLoading, false);
        verify(mockSignUpService.signUp(name, email, password)).called(1);
      });

      test('it shows an success snack message', () {
        verify(mockSnackBarService.show(
          'Cadastro realizado. Faça login para continuar.',
          duration: anyNamed('duration'),
        )).called(1);
      });

      test('it navigates to the login page with the email filled', () {
        verify(mockNavigator.navigate("/login?email=test@test.com")).called(1);
      });
    });

    group('when the sign up fails', () {
      test('it do not navigates to the login page', () async {
        await runFailingAction(HttpException(StatusCode.found, 'found'));
        verifyNever(mockNavigator.navigate(any));
      });

      group('because the user already exists', () {
        setUp(() => runFailingAction(HttpException(StatusCode.found, 'found')));

        test('it shows an error snack message', () {
          verify(mockSnackBarService.show(
            'E-mail já cadastrado.',
            duration: anyNamed('duration'),
          )).called(1);
        });
      });

      group('because the data is invalid', () {
        setUp(() {
          runFailingAction(HttpException(
            StatusCode.unprocessableEntity,
            'unprocessableEntity',
          ));
        });

        test('it shows an error snack message', () {
          verify(mockSnackBarService.show(
            'Campos inválidos.',
            duration: anyNamed('duration'),
          )).called(1);
        });
      });

      group('because the server is down', () {
        setUp(() {
          runFailingAction(HttpException(
            StatusCode.internalServerError,
            'internalServerError',
          ));
        });

        test('it shows an error snack message', () {
          verify(mockSnackBarService.show(
            'Erro interno do servidor.',
            duration: anyNamed('duration'),
          )).called(1);
        });
      });

      group('because of an unknown error', () {
        setUp(() {
          runFailingAction(HttpException(
            StatusCode.unknown,
            'unknown',
          ));
        });

        test('it shows an error snack message', () {
          verify(mockSnackBarService.show(
            'Algo deu errado ao realizar o cadastro. Tente novamente mais tarde.',
            duration: anyNamed('duration'),
          )).called(1);
        });
      });
    });
  });
}
