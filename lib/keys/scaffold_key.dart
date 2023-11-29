import 'package:flutter/material.dart';

class ScaffoldKey {
  final GlobalKey _scaffoldKey = GlobalKey();
  GlobalKey get getScaffoldKey => _scaffoldKey;
}
