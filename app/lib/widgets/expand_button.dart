import 'package:anotei/widgets/full_image_modal.dart';
import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key, required this.url, required this.productName});

  final String url;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () async {
        await showDialog(context: context, builder: (context) => FullImageModal(url: url, productName: productName));
      },
      icon: const Icon(Icons.zoom_in),
    );
  }
}
