import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SnackBarService {
  Future<SnackBarClosedReason> show(
    String text, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: duration,
    );

    final messenger = ScaffoldMessenger.of(
      Modular.routerDelegate.navigatorKey.currentContext!,
    );

    final result = messenger.showSnackBar(snackBar);

    return result.closed;
  }
}
