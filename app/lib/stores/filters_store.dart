import 'package:anotei/models/market.dart';
import 'package:mobx/mobx.dart';

part 'filters_store.g.dart';

class FiltersStore = FiltersStoreBase with _$FiltersStore;

abstract class FiltersStoreBase with Store {

  @observable
  ObservableList<Market> selectedMarkets = ObservableList<Market>();

  @observable
  ObservableList<String> selectedMarketNames = ObservableList<String>();

  @observable
  ObservableList<int> selectedMarketIds = ObservableList<int>();


  @action
  changeSelectedMarkets(Market market, bool isSelected) {
    if (isSelected == true) {
      selectedMarkets.add(market);
    } else {
      selectedMarkets.remove(market);
    }
  }

  @action
  changeSelectedMarketNames(String marketName, bool isSelected) {
    if (isSelected == true) {
      selectedMarketNames.add(marketName);
    } else {
      selectedMarketNames.remove(marketName);
    }
  }

  @action
  changeSelectedMarketIds(int marketId, bool isSelected) {
    if (isSelected == true) {
      selectedMarketIds.add(marketId);
    } else {
      selectedMarketIds.remove(marketId);
    }
  }

  @action
  extractSelectedMarketNames() {
    List<String> extractedNames = selectedMarkets.map((market) => market.name).toList();
    selectedMarketNames.addAll(extractedNames);
  }

  @action
  extractMarketIds() {
    List<int> extractedIds = selectedMarkets.map((market) => market.id).toList();
    selectedMarketIds.addAll(extractedIds);
  }
}
