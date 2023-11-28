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

  late final _$isPasswordObscureAtom =
      Atom(name: 'SignUpStoreBase.isPasswordObscure', context: context);

  @override
  bool get isPasswordObscure {
    _$isPasswordObscureAtom.reportRead();
    return super.isPasswordObscure;
  }

  @override
  set isPasswordObscure(bool value) {
    _$isPasswordObscureAtom.reportWrite(value, super.isPasswordObscure, () {
      super.isPasswordObscure = value;
    });
  }

  late final _$isPasswordConfirmationObscureAtom = Atom(
      name: 'SignUpStoreBase.isPasswordConfirmationObscure', context: context);

  @override
  bool get isPasswordConfirmationObscure {
    _$isPasswordConfirmationObscureAtom.reportRead();
    return super.isPasswordConfirmationObscure;
  }

  @override
  set isPasswordConfirmationObscure(bool value) {
    _$isPasswordConfirmationObscureAtom
        .reportWrite(value, super.isPasswordConfirmationObscure, () {
      super.isPasswordConfirmationObscure = value;
    });
  }

  late final _$signUpSuccessAtom =
      Atom(name: 'SignUpStoreBase.signUpSuccess', context: context);

  @override
  bool get signUpSuccess {
    _$signUpSuccessAtom.reportRead();
    return super.signUpSuccess;
  }

  @override
  set signUpSuccess(bool value) {
    _$signUpSuccessAtom.reportWrite(value, super.signUpSuccess, () {
      super.signUpSuccess = value;
    });
  }

  late final _$signUpAsyncAction =
      AsyncAction('SignUpStoreBase.signUp', context: context);

  @override
  Future<void> signUp(String name, String email, String password,
      String passwordConfirmation, BuildContext context) {
    return _$signUpAsyncAction.run(() =>
        super.signUp(name, email, password, passwordConfirmation, context));
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
isPasswordObscure: ${isPasswordObscure},
isPasswordConfirmationObscure: ${isPasswordConfirmationObscure},
signUpSuccess: ${signUpSuccess}
    ''';
  }
}
