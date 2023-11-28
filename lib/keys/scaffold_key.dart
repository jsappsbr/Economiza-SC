import 'package:flutter/material.dart';

class ScaffoldKey {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
}
