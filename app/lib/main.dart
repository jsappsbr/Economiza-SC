import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:anotei/modules/app_module.dart';
import 'app_widget.dart';

final app = ModularApp(module: AppModule(), child: const AppWidget());

void main() {
  return runApp(app);
}
