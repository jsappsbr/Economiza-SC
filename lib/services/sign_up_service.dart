import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:economiza_sc/exceptions/http_exception.dart';

class SignUpService {
  Future<void> signUp(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      final api = Modular.get<Dio>();

      final response = await api.post('/signup', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      return response.data;
    } on DioException catch (e) {
      throw HttpException.fromDioException(e);
    }
  }
}
