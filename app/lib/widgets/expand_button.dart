import 'package:anotei/widgets/full_image_modal.dart';
import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key, required this.url, required this.productName});

  final String url;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await showDialog(context: context, builder: (context) => FullImageModal(url: url, productName: productName));
      },
      child: const Text('Expandir'),
    );
  }
}
