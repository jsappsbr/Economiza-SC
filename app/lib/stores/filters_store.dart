import 'package:anotei/models/market.dart';
import 'package:mobx/mobx.dart';

part 'filters_store.g.dart';

class FiltersStore = FiltersStoreBase with _$FiltersStore;

abstract class FiltersStoreBase with Store {
  @observable
  Observable<String> search = Observable('');
  
  @observable
  ObservableList<Market> selectedMarkets = ObservableList<Market>();

  @action
  updateSearch(String value) => search.value = value;

  @action
  changeSelectedMarkets(Market market, bool isSelected) {
    if (isSelected) {
      selectedMarkets.add(market);
    } else {
      selectedMarkets.remove(market);
    }
  }
}
