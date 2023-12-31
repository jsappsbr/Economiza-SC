import 'package:economiza_sc/guards/auth_guard.dart';
import 'package:economiza_sc/modules/sign_up_module.dart';
import 'package:economiza_sc/services/auth_service.dart';
import 'package:economiza_sc/services/markets_service.dart';
import 'package:economiza_sc/services/products_service.dart';
import 'package:economiza_sc/stores/auth_store.dart';
import 'package:economiza_sc/stores/filters_store.dart';
import 'package:economiza_sc/stores/products_store.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:economiza_sc/services/snack_bar_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:economiza_sc/pages/home_page.dart';
import 'package:economiza_sc/pages/login_page.dart';
import 'package:economiza_sc/config/environment_variables.dart';
import 'package:dio/dio.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<SnackBarService>(() => SnackBarService());
    i.addSingleton<AuthService>(() => AuthService());
    i.addSingleton<MarketsService>(() => MarketsService());
    i.addSingleton<ProductsService>(() => ProductsService());
    i.addSingleton<AuthStore>(() => AuthStore());
    i.addSingleton<FiltersStore>(() => FiltersStore());
    i.addSingleton<MarketsStore>(() => MarketsStore());
    i.addSingleton<ProductsStore>(() => ProductsStore());

    i.addSingleton<Dio>(() {
      final options = BaseOptions(baseUrl: EnvironmentVariable.apiBaseUrl);
      final dio = Dio(options);

      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await Modular.get<AuthService>().getApiToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
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
    r.child('/login', child: (_) => LoginPage(r.args.queryParams['email']));
    r.module('/sign-up', module: SignUpModule());
  }
}
