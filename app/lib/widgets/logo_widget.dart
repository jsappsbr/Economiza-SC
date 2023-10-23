import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.customAsset});

  final String customAsset;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 120,
      child: Image.asset(
        customAsset,
        fit: BoxFit.cover,
      ),
    );
  }
}