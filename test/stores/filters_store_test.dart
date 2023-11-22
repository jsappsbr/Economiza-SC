import 'package:economiza_sc/models/market.dart';
import 'package:economiza_sc/modules/app_module.dart';
import 'package:economiza_sc/stores/filters_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';

void main() {
  final market = Market(id: 1, name: '', website: '');

  setUp(() {
    Modular.init(AppModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  group('FilterStore class', () {
    group('updateSearch action', () {
      test('When the "updateSearch" action is called, the search value is updated', () {
        String newValue = 'newValue';
        final filterStore = FiltersStore();
        filterStore.search = mobx.Observable('');
        filterStore.updateSearch(newValue);

        expect(filterStore.search.value, newValue);
      });
    });
    group('changeSelectedMarkets action', () {
      test('When the "changeSelectedMarkets" action is called with a market that\'s selected, the market will be added to the list of selected markets', () {
        final filterStore = FiltersStore();
        when(filterStore.changeSelectedMarkets(market, true));

        expect(filterStore.selectedMarkets, contains(market));
      });
      test('When the "changeSelectedMarkets" action is called with a market that\'s not selected, the market will be removed from the list of selected markets', () {
        final filterStore = FiltersStore();
        filterStore.selectedMarkets.add(market);
        when(filterStore.changeSelectedMarkets(market, false));

        expect(filterStore.selectedMarkets, isNot(contains(market)));
      });
    });
    group('cleanSelectedMarkets action', () {
      test('When the "cleanSelectedMarkets" action is called, all markets are removed from the list of selectedMarkets', () {
        final filterStore = FiltersStore();
        filterStore.selectedMarkets.add(market);
        filterStore.cleanSelectedMarkets();

        expect(filterStore.selectedMarkets, isEmpty);
      });
    });
  });
}
