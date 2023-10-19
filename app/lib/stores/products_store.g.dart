// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on ProductsStoreBase, Store {
  late final _$productsAtom =
      Atom(name: 'ProductsStoreBase.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('ProductsStoreBase.fetchProducts', context: context);

  @override
  Future fetchProducts(String search) {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts(search));
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
