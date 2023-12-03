import 'package:economiza_sc/stores/sign_up_store.dart';
import 'package:economiza_sc/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpStore = Modular.get<SignUpStore>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "Teste");
  final _emailController = TextEditingController(text: "test@test.com");
  final _passwordController = TextEditingController(text: "12345678");
  final _passwordConfirmationController =
      TextEditingController(text: "12345678");

  _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _signUpStore.signUp(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );
  }

  bool _isEmail(String input) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
          body: Center(
              child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(
                      assetPath: 'assets/images/logo_full_transparent_bag.png'),
                  TextFormField(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                    key: const Key('nameField'),
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: 'Nome',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.grey)),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Campo obrigatório';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                    key: const Key('emailField'),
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.grey)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (_isEmail(_emailController.text) == false) {
                        return 'Digite um email válido';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                      key: const Key('passwordField'),
                      controller: _passwordController,
                      obscureText: _signUpStore.isPasswordObscure,
                      decoration: InputDecoration(
                          hintText: 'Senha',
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  _signUpStore.changePasswordVisibility(),
                              icon: Icon(_signUpStore.isPasswordObscure == false
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (value.length < 4) {
                          return 'Utilize no mínimo 4 caracteres';
                        }
                        return null;
                      }),
                  TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                      key: const Key('passwordConfirmationField'),
                      controller: _passwordConfirmationController,
                      obscureText: _signUpStore.isPasswordConfirmationObscure,
                      decoration: InputDecoration(
                          hintText: 'Confirmação de senha',
                          suffixIcon: IconButton(
                              onPressed: () => _signUpStore
                                  .changePasswordConfirmationVisibility(),
                              icon: Icon(
                                  _signUpStore.isPasswordConfirmationObscure ==
                                          false
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Campo obrigatório';
                        } else if (value != _passwordController.text) {
                          return 'As senhas não conferem';
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Observer(builder: (_) {
                      return ElevatedButton(
                        key: const Key('signUpButton'),
                        onPressed: () =>
                            _signUpStore.isLoading ? null : _handleSubmit(),
                        child: _signUpStore.isLoading
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  TextButton(
                      onPressed: () => Modular.to.navigate('/login'),
                      child: const Text('Entrar')),
                ],
              ),
            ),
          ),
        ),
      )));
    });
  }
}
