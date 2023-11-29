import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RequestTimeout implements Exception {}

class AccountAlreadyExistent implements Exception {}

class FormValidationError implements Exception {}

class TooManyRequests implements Exception {}

class UnknownError implements Exception {}

class SignUpService {
  Future<void> signUp(String name, String email, String password, String passwordConfirmation) async {
    final api = Modular.get<Dio>();
    
    var response = await api.post('/signup', data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    if (response.statusCode == 408) {
      throw RequestTimeout();
    } else if (response.statusCode == 409) {
      throw AccountAlreadyExistent();
    } else if (response.statusCode == 422) {
      throw FormValidationError();
    } else if (response.statusCode == 429) {
      throw TooManyRequests();
    } else {
      throw UnknownError();
    } 
  }
}
