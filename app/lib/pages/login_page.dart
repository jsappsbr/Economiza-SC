import 'package:economiza_sc/stores/auth_store.dart';
import 'package:economiza_sc/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoginForm()),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authStore = Modular.get<AuthStore>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'test@test.com');
  final _passwordController = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(assetPath: 'assets/images/logo_economiza_sc_round.png'),
              TextFormField(
                key: const Key('emailField'),
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                  key: const Key('passwordField'),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    return null;
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Observer(builder: (_) {
                  return ElevatedButton(
                    key: const Key('loginButton'),
                    onPressed: () => _authStore.isAuthenticating ? null : _handleSubmit(context),
                    child: _authStore.isAuthenticating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Entrar'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _authStore.login(_emailController.text, _passwordController.text);
  }
}
