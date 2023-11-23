import 'dart:io';
import 'package:economiza_sc/models/product.dart';
import 'package:economiza_sc/widgets/expand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final product = Product(
    id: 1,
    marketId: 1,
    name: 'Test Product',
    price: 10,
    picture: 'https://test.com/image.jpg',
    link: 'https://test.com',
    sku: '123',
  );

  setUpAll(() {
    // required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  group('ExpandButton widget', () {
    testWidgets('when tapped it shows the product title and image',
        (tester) async {
      // It is necessary to wrap the widget with MaterialApp
      // because the ExpandButton uses the showDialog method
      // which requires the MaterialApp to be present in the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandButton(
              product: product,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ExpandButton));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
