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
    group('updateSearch method', () {
      test('The value of search is updated succesfully', () {
        String newValue = 'newValue';
        final filterStore = FiltersStore();
        filterStore.search = mobx.Observable('');
        when(filterStore.updateSearch(newValue));

        expect(filterStore.search.value, newValue);
      });
    });
    group('changeSelectedMarkets', () {
      test('New Market is added successfully when isSelected is true', () {
        final filterStore = FiltersStore();
        when(filterStore.changeSelectedMarkets(market, true));

        expect(filterStore.selectedMarkets, contains(market));
      });
      test('A given market is removed successfully when isSelected is false', () {
        final filterStore = FiltersStore();
        filterStore.selectedMarkets.add(market);
        when(filterStore.changeSelectedMarkets(market, false));

        expect(filterStore.selectedMarkets, isNot(contains(market)));
      });
    });
    group('cleanSelectedMarkets method', () {
      test('selectedMarkets are cleaned succesfully', () {
        final filterStore = FiltersStore();
        filterStore.selectedMarkets.add(market);
        when(filterStore.cleanSelectedMarkets());

        expect(filterStore.selectedMarkets, isEmpty);
      });
    });
  });
}
