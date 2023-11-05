import 'package:anotei/models/product.dart';
import 'package:anotei/widgets/full_image_modal.dart';
import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () async {
        await showDialog(context: context, builder: (context) => FullImageModal(product: product));
      },
      icon: const Icon(Icons.zoom_in),
    );
  }
}
