import 'package:economiza_sc/models/product.dart';
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
          SizedBox(
            height: 372,
            width: 372,
            child: ListView(
              children: [
                Image.network(product.picture),
              ],
            ),
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
