import 'package:economiza_sc/models/product.dart';
import 'package:economiza_sc/services/products_service.dart';
import 'package:economiza_sc/stores/filters_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'products_store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

abstract class ProductsStoreBase with Store {
  final _filtersStore = Modular.get<FiltersStore>();
  final _productsService = Modular.get<ProductsService>();

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  int page = 1;

  @observable
  int productsPerPage = 20;

  @observable
  bool productsLoading = false;

  late ScrollController scrollController;

  @action
  initScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      // If the user scrolls at least 80% of the screen, new products are loaded
      if (scrollController.position.pixels >= (0.8 * scrollController.position.maxScrollExtent)) {
        fetchProducts();
      }
    });
  }

  @action
  fetchProducts() async {
    if (productsLoading) {
      return;
    }

    try {
      productsLoading = true;
      final searchResult = await _productsService.search(
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

  @action
  cleanProductSelection() async {
    page = 1;
    products.clear();
    fetchProducts();
  }

  @action
  cleanProductAndMarketSelection() async {
    page = 1;
    _filtersStore.selectedMarkets.clear();
    products.clear();
    fetchProducts();
  }
}
