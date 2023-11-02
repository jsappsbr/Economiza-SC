import 'package:anotei/models/product.dart';
import 'package:anotei/services/products_service.dart';
import 'package:anotei/stores/filters_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'products_store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

abstract class ProductsStoreBase with Store {
  final _filtersStore = Modular.get<FiltersStore>();

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  int page = 1;

  @observable
  int productsPerPage = 20;

  @observable
  bool productsLoading = false;

  @action
  fetchProducts() async {
    if (!productsLoading) {
      productsLoading = true;
      try {
        final searchResult = await ProductsService().search(
          _filtersStore.search.value,
          page,
          productsPerPage,
          marketIds: _filtersStore.selectedMarkets.map((e) => e.id).toList(),
        );

        if (searchResult.isNotEmpty) {
          products.addAll(searchResult);
          page++;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } finally {
        productsLoading = false;
      }
    }
  }
}
