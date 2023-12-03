import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:economiza_sc/modules/core_module.dart';
import 'app_widget.dart';

final app = ModularApp(module: CoreModule(), child: const AppWidget());

void main() {
  return runApp(app);
}
