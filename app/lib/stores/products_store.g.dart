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

  late final _$pageAtom =
      Atom(name: 'ProductsStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$productsPerPageAtom =
      Atom(name: 'ProductsStoreBase.productsPerPage', context: context);

  @override
  int get productsPerPage {
    _$productsPerPageAtom.reportRead();
    return super.productsPerPage;
  }

  @override
  set productsPerPage(int value) {
    _$productsPerPageAtom.reportWrite(value, super.productsPerPage, () {
      super.productsPerPage = value;
    });
  }

  late final _$productsLoadingAtom =
      Atom(name: 'ProductsStoreBase.productsLoading', context: context);

  @override
  bool get productsLoading {
    _$productsLoadingAtom.reportRead();
    return super.productsLoading;
  }

  @override
  set productsLoading(bool value) {
    _$productsLoadingAtom.reportWrite(value, super.productsLoading, () {
      super.productsLoading = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('ProductsStoreBase.fetchProducts', context: context);

  @override
  Future fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  @override
  String toString() {
    return '''
products: ${products},
page: ${page},
productsPerPage: ${productsPerPage},
productsLoading: ${productsLoading}
    ''';
  }
}
