import 'package:anotei/models/product.dart';
import 'package:anotei/services/products_service.dart';
import 'package:anotei/stores/filters_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'products_store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

abstract class ProductsStoreBase with Store {
  final _filtersStore = Modular.get<FiltersStore>();

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @action
  fetchProducts() async {
    final searchResult = await ProductsService().search(
      _filtersStore.search.value,
      marketIds: _filtersStore.selectedMarkets.map((e) => e.id).toList(),
    );
    products.clear();
    products.addAll(searchResult);
  }
}
