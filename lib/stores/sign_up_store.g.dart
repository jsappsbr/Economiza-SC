// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpStore on SignUpStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'SignUpStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isPasswordVisibleAtom =
      Atom(name: 'SignUpStoreBase.isPasswordVisible', context: context);

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  late final _$isPasswordConfirmationVisibleAtom = Atom(
      name: 'SignUpStoreBase.isPasswordConfirmationVisible', context: context);

  @override
  bool get isPasswordConfirmationVisible {
    _$isPasswordConfirmationVisibleAtom.reportRead();
    return super.isPasswordConfirmationVisible;
  }

  @override
  set isPasswordConfirmationVisible(bool value) {
    _$isPasswordConfirmationVisibleAtom
        .reportWrite(value, super.isPasswordConfirmationVisible, () {
      super.isPasswordConfirmationVisible = value;
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

  late final _$SignUpStoreBaseActionController =
      ActionController(name: 'SignUpStoreBase', context: context);

  @override
  void changePasswordVisibility() {
    final _$actionInfo = _$SignUpStoreBaseActionController.startAction(
        name: 'SignUpStoreBase.changePasswordVisibility');
    try {
      return super.changePasswordVisibility();
    } finally {
      _$SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePasswordConfirmationVisibility() {
    final _$actionInfo = _$SignUpStoreBaseActionController.startAction(
        name: 'SignUpStoreBase.changePasswordConfirmationVisibility');
    try {
      return super.changePasswordConfirmationVisibility();
    } finally {
      _$SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isPasswordVisible: ${isPasswordVisible},
isPasswordConfirmationVisible: ${isPasswordConfirmationVisible}
    ''';
  }
}
