import 'package:economiza_sc/models/market.dart';
import 'package:economiza_sc/modules/app_module.dart';
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
    Modular.init(AppModule());
    Modular.replaceInstance<MarketsService>(mockMarketsService);
  });

  tearDown(() {
    Modular.destroy();
  });

  group('MarketStore class', () {
    group('fetchMarkets method', () {
      test('Markets are added successfully', () async {
        when(mockMarketsService.search()).thenAnswer((_) async => [market]);
        final marketStore = MarketsStore();
        await marketStore.fetchMarkets();

        expect(marketStore.markets, contains(market));
      });
      group('extractMarketNames method', () {
        test('Market names are extracted successfully', () {
          final marketStore = MarketsStore();
          marketStore.markets.add(market);
          when(marketStore.extractMarketNames());

          expect(marketStore.marketNames, [market.name]);
        });
      });
      group('extractMarketIds method', () {
        test('Market IDs are extracted successfully', () {
          final marketStore = MarketsStore();
          marketStore.markets.add(market);
          when(marketStore.extractMarketIds());

          expect(marketStore.marketIds, [market.id]);
        });
      });
    });
  });
}
