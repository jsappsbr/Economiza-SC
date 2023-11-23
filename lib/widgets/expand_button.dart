import 'package:economiza_sc/models/product.dart';
import 'package:economiza_sc/widgets/full_image_modal.dart';
import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      hoverColor: Colors.grey.shade200,
      onPressed: () async {
        await showDialog(context: context, builder: (context) => FullImageModal(product: product));
      },
      icon: const Icon(Icons.zoom_in, color: Colors.black),
    );
  }
}
