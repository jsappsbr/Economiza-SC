import 'package:economiza_sc/models/user.dart';
import 'package:economiza_sc/modules/app_module.dart';
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

  Modular.bindModule(AppModule());
  Modular.replaceInstance<AuthService>(mockAuthService);

  setUp(() {
    reset(mockAuthService);
  });

  group('when the authentication succeeds', () {
    test('it sets the user as authenticated', () async {
      final user = User(
        id: 1,
        name: 'Test User',
        email: email,
      );

      when(mockAuthService.login(email, password))
          .thenAnswer((_) async => user);

      final authStore = AuthStore();

      await authStore.login(email, password);

      expect(authStore.isLogged, true);
      expect(authStore.isAuthenticating, false);
      expect(authStore.user, user);
      verify(mockAuthService.login(email, password)).called(1);
    });
  });

  group('when then authentication fails', () {
    test('it sets the user as not authenticated', () async {
      when(mockAuthService.login(any, any)).thenThrow(Exception());

      final authStore = AuthStore();

      await authStore.login(email, password);

      expect(authStore.isLogged, false);
      expect(authStore.isAuthenticating, false);
      expect(authStore.user, null);
      verify(mockAuthService.login(email, password)).called(1);
    });
  });
}
