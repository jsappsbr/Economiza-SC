import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SnackBarService {
  Future<SnackBarClosedReason> show(
    String text, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final result = ScaffoldMessenger.of(
      Modular.routerDelegate.navigatorKey.currentContext!,
    ).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: duration,
      ),
    );

    return result.closed;
  }
}
