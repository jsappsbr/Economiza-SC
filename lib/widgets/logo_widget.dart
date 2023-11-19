import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10), 
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        width: 200, 
        height: 200, 
      ),
    );
  }
}