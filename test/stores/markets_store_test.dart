import 'package:economiza_sc/models/market.dart';
import 'package:economiza_sc/modules/core_module.dart';
import 'package:economiza_sc/services/markets_service.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<MarketsService>()])
import 'markets_store_test.mocks.dart';

void main() {
  final market = Market(id: 1, name: '', website: '');
  final mockMarketsService = MockMarketsService();

  setUp(() {
    reset(mockMarketsService);
    Modular.init(CoreModule());
    Modular.replaceInstance<MarketsService>(mockMarketsService);
  });

  tearDown(() {
    Modular.destroy();
  });

  group('MarketStore class', () {
    group('fetchMarkets action', () {
      test('When the "fetchMarkets" action is called, markets are added to the markets observable successfully', () async {
        when(mockMarketsService.search()).thenAnswer((_) async => [market]);
        final marketStore = MarketsStore();
        await marketStore.fetchMarkets();

        expect(marketStore.markets, contains(market));
      });
      group('extractMarketNames action', () {
        test(
            'When the "extractMarketNames" action is called the names property of each market is extracted and added to the marketNames observable successfully',
            () {
          final marketStore = MarketsStore();
          marketStore.markets.add(market);
          marketStore.extractMarketNames();

          expect(marketStore.marketNames, [market.name]);
        });
      });
      group('extractMarketIds action', () {
        test(
            'When the "extractMarketIds " action is called the ids property of each market is extracted and added to the marketIds observable successfully',
            () {
          final marketStore = MarketsStore();
          marketStore.markets.add(market);
          marketStore.extractMarketIds();

          expect(marketStore.marketIds, [market.id]);
        });
      });
    });
  });
}
