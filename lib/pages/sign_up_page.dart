import 'package:economiza_sc/stores/auth_store.dart';
import 'package:economiza_sc/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _authStore = Modular.get<AuthStore>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'test@test.com');
  final _passwordController = TextEditingController(text: 'password');

  _handleSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _authStore.login(_emailController.text, _passwordController.text);
  }

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
              const LogoWidget(assetPath: 'assets/images/logo_full_transparent_bag.png'),
              const SizedBox(height: 30),
              TextFormField(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                key: const Key('emailField'),
                controller: _emailController,
                decoration: InputDecoration(hintText: 'E-mail', hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
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
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Criar conta'),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Text(
                  'Já possui uma conta?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                ),
              ),
              TextButton(onPressed: () => Modular.to.navigate('/login'), child: const Text('Entrar')),
            ],
          ),
        ),
      ),
    );
  }
}
