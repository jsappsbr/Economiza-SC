// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$isLoggedAtom =
      Atom(name: 'AuthStoreBase.isLogged', context: context);

  @override
  bool get isLogged {
    _$isLoggedAtom.reportRead();
    return super.isLogged;
  }

  @override
  set isLogged(bool value) {
    _$isLoggedAtom.reportWrite(value, super.isLogged, () {
      super.isLogged = value;
    });
  }

  late final _$isAuthenticatingAtom =
      Atom(name: 'AuthStoreBase.isAuthenticating', context: context);

  @override
  bool get isAuthenticating {
    _$isAuthenticatingAtom.reportRead();
    return super.isAuthenticating;
  }

  @override
  set isAuthenticating(bool value) {
    _$isAuthenticatingAtom.reportWrite(value, super.isAuthenticating, () {
      super.isAuthenticating = value;
    });
  }

  late final _$isFetchingCurrentUserAtom =
      Atom(name: 'AuthStoreBase.isFetchingCurrentUser', context: context);

  @override
  bool get isFetchingCurrentUser {
    _$isFetchingCurrentUserAtom.reportRead();
    return super.isFetchingCurrentUser;
  }

  @override
  set isFetchingCurrentUser(bool value) {
    _$isFetchingCurrentUserAtom.reportWrite(value, super.isFetchingCurrentUser,
        () {
      super.isFetchingCurrentUser = value;
    });
  }

  late final _$userAtom = Atom(name: 'AuthStoreBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthStoreBase.login', context: context);

  @override
  Future<void> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$fetchCurrentUserAsyncAction =
      AsyncAction('AuthStoreBase.fetchCurrentUser', context: context);

  @override
  Future fetchCurrentUser() {
    return _$fetchCurrentUserAsyncAction.run(() => super.fetchCurrentUser());
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
isLogged: ${isLogged},
isAuthenticating: ${isAuthenticating},
isFetchingCurrentUser: ${isFetchingCurrentUser},
user: ${user}
    ''';
  }
}
