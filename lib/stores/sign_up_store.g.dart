// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpStore on SignUpStoreBase, Store {
  late final _$isCreatingUserAtom =
      Atom(name: 'SignUpStoreBase.isCreatingUser', context: context);

  @override
  bool get isCreatingUser {
    _$isCreatingUserAtom.reportRead();
    return super.isCreatingUser;
  }

  @override
  set isCreatingUser(bool value) {
    _$isCreatingUserAtom.reportWrite(value, super.isCreatingUser, () {
      super.isCreatingUser = value;
    });
  }

  late final _$signUpAsyncAction =
      AsyncAction('SignUpStoreBase.signUp', context: context);

  @override
  Future<void> signUp(
      String name, String email, String password, String passwordConfirmation) {
    return _$signUpAsyncAction
        .run(() => super.signUp(name, email, password, passwordConfirmation));
  }

  @override
  String toString() {
    return '''
isCreatingUser: ${isCreatingUser}
    ''';
  }
}
