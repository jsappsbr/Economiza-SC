import 'package:anotei/models/product.dart';
import 'package:flutter/material.dart';

class FullImageModal extends StatelessWidget {
  const FullImageModal({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(product.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 427, maxWidth: 372),
            child: Image.network(product.picture),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Fechar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
