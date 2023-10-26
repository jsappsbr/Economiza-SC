import 'package:anotei/models/product.dart';
import 'package:anotei/services/products_service.dart';
import 'package:mobx/mobx.dart';

part 'products_store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

abstract class ProductsStoreBase with Store {
  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @action
  fetchProducts(String search, {List<int>? marketIds}) async {
    final searchResult = await ProductsService().search(search, marketIds: marketIds);
    products.clear();
    products.addAll(searchResult);
  }
}
