import 'package:economiza_sc/models/user.dart';
import 'package:economiza_sc/modules/core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:economiza_sc/stores/auth_store.dart';
import 'package:economiza_sc/services/auth_service.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'auth_store_test.mocks.dart';

void main() {
  const email = 'test@test.com';
  const password = 'password';
  final mockAuthService = MockAuthService();

  setUp(() {
    reset(mockAuthService);
    Modular.init(CoreModule());
    Modular.replaceInstance<AuthService>(mockAuthService);
  });

  tearDown(() {
    Modular.destroy();
  });

  group('AuthStore class', () {
    group('login action', () {
      test('When the login action is called, the user is authenticated successfully', () async {
        final user = User(
          id: 1,
          name: 'Test User',
          email: email,
        );

        when(mockAuthService.login(email, password)).thenAnswer((_) async => user);

        final authStore = AuthStore();

        await authStore.login(email, password);

        expect(authStore.isLogged, true);
        expect(authStore.isAuthenticating, false);
        expect(authStore.user, user);
        verify(mockAuthService.login(email, password)).called(1);
      });
      test('When the login action is called, the user is not authenticated successfully', () async {
        when(mockAuthService.login(any, any)).thenThrow(Exception());

        final authStore = AuthStore();

        await authStore.login(email, password);

        expect(authStore.isLogged, false);
        expect(authStore.isAuthenticating, false);
        expect(authStore.user, null);
        verify(mockAuthService.login(email, password)).called(1);
      });
    });

    group('logout action', () {
      test('When the logout action is called, the user is logged out successfully', () async {
        final authStore = AuthStore();
        authStore.user = User(id: 1, name: 'Test User', email: email);
        when(mockAuthService.logout()).thenAnswer((_) async {});

        await authStore.logout();

        expect(authStore.isLogged, false);
        expect(authStore.user, null);
        verify(mockAuthService.logout()).called(1);
      });

      test('When the logout action is called, the user is not logged out successfully', () async {
        final authStore = AuthStore();
        authStore.isLogged = true;
        authStore.user = User(id: 1, name: 'Test User', email: email);
        when(mockAuthService.logout()).thenThrow(Exception());
        await authStore.logout();

        expect(authStore.isLogged, true);
        expect(authStore.user, isNotNull);
        verify(mockAuthService.logout()).called(1);
      });
    });
  });
}
