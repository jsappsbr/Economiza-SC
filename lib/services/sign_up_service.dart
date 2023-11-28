import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpService {
  Future<void> signUp(String name, String email, String password, String passwordConfirmation) async {
    final api = Modular.get<Dio>();
    await api.post('/signup', data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
  }
}
