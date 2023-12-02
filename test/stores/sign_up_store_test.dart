// import 'package:economiza_sc/modules/core_module.dart';
// import 'package:economiza_sc/services/sign_up_service.dart';
// import 'package:economiza_sc/stores/sign_up_store.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// @GenerateNiceMocks([MockSpec<SignUpService>()])
// import 'sign_up_store_test.mocks.dart';
//
// void main() {
//   const name = 'Peter';
//   const email = 'test@test.com';
//   const password = 'password';
//   final mockSignUpService = MockSignUpService();
//
//   setUp(() {
//     TestWidgetsFlutterBinding.ensureInitialized();
//     reset(mockSignUpService);
//     Modular.init(CoreModule());
//     Modular.replaceInstance<SignUpService>(mockSignUpService);
//   });
//
//   tearDown(() {
//     Modular.destroy();
//   });
//
//   group('SignUpStore class', () {
//     group('signUp action', () {
//       test('When the signUp action is called, an account is created successfully', () async {
//         final signUpStore = SignUpStore();
//
//         when(mockSignUpService.signUp(name, email, password, password)).thenAnswer((_) async => Future<void>.value());
//
//         await signUpStore.signUp(name, email, password, password);
//
//         expect(signUpStore.signUpSuccess, true);
//         expect(signUpStore.isLoading, false);
//       });
//       group('When the signUp action is called, an exception is thrown', () {
//         test('When the request takes too long, an exception with status code 408 is thrown', () async {
//           final signUpStore = SignUpStore();
//
//           when(mockSignUpService.signUp(name, email, password, password)).thenThrow(RequestTimeout());
//
//           await signUpStore.signUp(name, email, password, password);
//
//           expect(signUpStore.isLoading, false);
//           expect(signUpStore.signUpSuccess, false);
//         });
//         test('Exception with status code 409 is thrown', () async {
//           final signUpStore = SignUpStore();
//
//           when(mockSignUpService.signUp(name, email, password, password)).thenThrow(AccountAlreadyExistent());
//
//           await signUpStore.signUp(name, email, password, password);
//
//           expect(signUpStore.isLoading, false);
//           expect(signUpStore.signUpSuccess, false);
//         });
//         test('Exception with status code 422 is thrown', () async {
//           final signUpStore = SignUpStore();
//
//           when(mockSignUpService.signUp(name, email, password, password)).thenThrow(FormValidationError());
//
//           await signUpStore.signUp(name, email, password, password);
//
//           expect(signUpStore.isLoading, false);
//           expect(signUpStore.signUpSuccess, false);
//         });
//         test('Exception with status code 429 is thrown', () async {
//           final signUpStore = SignUpStore();
//
//           when(mockSignUpService.signUp(name, email, password, password)).thenThrow(TooManyRequests());
//
//           await signUpStore.signUp(name, email, password, password);
//
//           expect(signUpStore.isLoading, false);
//           expect(signUpStore.signUpSuccess, false);
//         });
//         test('Exception with an unknown status code is thrown', () async {
//           final signUpStore = SignUpStore();
//
//           when(mockSignUpService.signUp(name, email, password, password)).thenThrow(UnknownError());
//
//           await signUpStore.signUp(name, email, password, password);
//
//           expect(signUpStore.isLoading, false);
//           expect(signUpStore.signUpSuccess, false);
//         });
//       });
//     });
//     group('changePasswordVisibility action', () {
//       test('When the changePasswordVisibility action is called and isPasswordObscure is true, it becomes false', () {
//         final signUpStore = SignUpStore();
//         signUpStore.isPasswordObscure = true;
//         signUpStore.changePasswordVisibility();
//
//         expect(signUpStore.isPasswordObscure, false);
//       });
//       test('When the changePasswordVisibility action is called and isPasswordObscure is false, it becomes true', () {
//         final signUpStore = SignUpStore();
//         signUpStore.isPasswordObscure = false;
//         signUpStore.changePasswordVisibility();
//
//         expect(signUpStore.isPasswordObscure, true);
//       });
//     });
//
//     group('changePasswordConfirmationVisibility action', () {
//       test('When the changePasswordConfirmationVisibility action is called and isPasswordObscure is true, it becomes false', () {
//         final signUpStore = SignUpStore();
//         signUpStore.isPasswordConfirmationObscure = true;
//         signUpStore.changePasswordConfirmationVisibility();
//
//         expect(signUpStore.isPasswordConfirmationObscure, false);
//       });
//       test('When the changePasswordConfirmationVisibility action is called and isPasswordObscure is false, it becomes true', () {
//         final signUpStore = SignUpStore();
//         signUpStore.isPasswordConfirmationObscure = false;
//         signUpStore.changePasswordConfirmationVisibility();
//
//         expect(signUpStore.isPasswordConfirmationObscure, true);
//       });
//     });
//   });
// }
