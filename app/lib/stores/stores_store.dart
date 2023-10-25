import 'package:anotei/models/store.dart' as store;
import 'package:anotei/services/stores_service.dart';
import 'package:mobx/mobx.dart';

part 'stores_store.g.dart';

class StoresStore = StoresStoreBase with _$StoresStore;

abstract class StoresStoreBase with Store {
  @observable
  ObservableList<store.Store> stores = ObservableList<store.Store>();

  @action
  Future<List<store.Store>> fetchStores(String search) async {
    final searchResult = await StoresService().search(search);
    searchResult.clear();
    searchResult.addAll(searchResult);
    return searchResult;
  }

  @action
  List<String> extractStoreNames(List<store.Store> stores) {
    return stores.map((store) => store.name).toList();
  }
}
