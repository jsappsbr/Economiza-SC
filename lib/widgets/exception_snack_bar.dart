import 'package:flutter/material.dart';

class ExceptionSnackBar {
  void displaySnackBar(String exceptionMessage, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exceptionMessage)));
  }
}