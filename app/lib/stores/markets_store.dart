import 'package:anotei/models/market.dart';
import 'package:anotei/services/markets_service.dart';
import 'package:mobx/mobx.dart';

part 'markets_store.g.dart';

class MarketsStore = MarketsStoreBase with _$MarketsStore;

abstract class MarketsStoreBase with Store {
  
  @observable
  ObservableList<Market> markets = ObservableList<Market>();

  @observable
  ObservableList<String> marketNames = ObservableList<String>();

  @observable
  ObservableList<int> marketIds = ObservableList<int>();

  @action
  fetchMarkets() async {
    final fetchedMarkets = await MarketsService().search();
    markets.addAll(fetchedMarkets);
  }

  @action
  extractMarketNames() {
    List<String> extractedNames = markets.map((market) => market.name).toList();
    marketNames.addAll(extractedNames);
  }

  @action
  extractMarketIds() {
    List<int> extractedIds = markets.map((market) => market.id).toList();
    marketIds.addAll(extractedIds);
  }
}
