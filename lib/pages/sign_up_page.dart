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
  final _signUpStore = SignUpStore();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  _handleSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _signUpStore.signUp(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      _passwordConfirmationController.text,
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
                  const LogoWidget(assetPath: 'assets/images/logo_full_transparent_bag.png'),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    key: const Key('nameField'),
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Nome', hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Campo obrigatório';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    key: const Key('emailField'),
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'E-mail', hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                      key: const Key('passwordField'),
                      controller: _passwordController,
                      obscureText: !_signUpStore.isPasswordVisible,
                      decoration: InputDecoration(
                          hintText: 'Senha',
                          suffixIcon: IconButton(
                              onPressed: () => _signUpStore.changePasswordVisibility(),
                              icon: Icon(_signUpStore.isPasswordVisible == true ? Icons.visibility : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 4) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      }),
                  TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                      key: const Key('passwordConfirmationField'),
                      controller: _passwordConfirmationController,
                      obscureText: !_signUpStore.isPasswordConfirmationVisible,
                      decoration: InputDecoration(
                          hintText: 'Confirmação de senha',
                          suffixIcon: IconButton(
                              onPressed: () => _signUpStore.changePasswordConfirmationVisibility(),
                              icon: Icon(_signUpStore.isPasswordConfirmationVisible == true ? Icons.visibility : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 4) {
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
                        onPressed: () => _signUpStore.isLoading ? null : _handleSubmit(context),
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    ),
                  ),
                  TextButton(onPressed: () => Modular.to.navigate('/login'), child: const Text('Entrar')),
                ],
              ),
            ),
          ),
        ),
      )));
    });
  }
}
