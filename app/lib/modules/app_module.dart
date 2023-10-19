import 'package:anotei/guards/auth_guard.dart';
import 'package:anotei/stores/auth_store.dart';
import 'package:anotei/stores/products_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:anotei/pages/home_page.dart';
import 'package:anotei/pages/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AuthStore>(() => AuthStore());
    i.addSingleton<ProductsStore>(() => ProductsStore());
    i.addSingleton<Dio>(() {
      String baseUrl = '';

      if (kIsWeb) {
        baseUrl = 'http://localhost:8000/api';
      } else if (Platform.isIOS || Platform.isAndroid) {
        baseUrl = 'http://10.0.2.2:8000/api';
      } else {
        baseUrl = 'http://localhost:8000/api';
      }

      final options = BaseOptions(baseUrl: baseUrl);
      final dio = Dio(options);

      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('api_token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${token}';
          }

          return handler.next(options);
        },
      ));

      return dio;
    });
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const HomePage(), guards: [AuthGuard()]);
    r.child('/login', child: (_) => const LoginPage());
  }
}
