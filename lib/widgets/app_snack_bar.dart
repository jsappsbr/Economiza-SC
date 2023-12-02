import 'package:flutter/material.dart';

class AppSnackBar {
  static Future<SnackBarClosedReason> show(
    BuildContext context,
    Widget content, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final result = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        duration: duration,
      ),
    );

    return result.closed;
  }
}
