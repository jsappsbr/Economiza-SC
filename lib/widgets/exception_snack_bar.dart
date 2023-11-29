import 'package:economiza_sc/keys/scaffold_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExceptionSnackBar {
  final _scaffoldKey = Modular.get<ScaffoldKey>();

  void displaySnackBar(String exceptionMessage) {
    final GlobalKey scaffoldKeyValue = _scaffoldKey.getScaffoldKey;
    final BuildContext? currentContext = scaffoldKeyValue.currentContext;

    if (currentContext != null) {
      ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text(exceptionMessage)));
    }
  }
}
