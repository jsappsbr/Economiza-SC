// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FiltersStore on FiltersStoreBase, Store {
  late final _$searchAtom =
      Atom(name: 'FiltersStoreBase.search', context: context);

  @override
  Observable<String> get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(Observable<String> value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$selectedMarketsAtom =
      Atom(name: 'FiltersStoreBase.selectedMarkets', context: context);

  @override
  ObservableList<Market> get selectedMarkets {
    _$selectedMarketsAtom.reportRead();
    return super.selectedMarkets;
  }

  @override
  set selectedMarkets(ObservableList<Market> value) {
    _$selectedMarketsAtom.reportWrite(value, super.selectedMarkets, () {
      super.selectedMarkets = value;
    });
  }

  late final _$FiltersStoreBaseActionController =
      ActionController(name: 'FiltersStoreBase', context: context);

  @override
  dynamic updateSearch(String value) {
    final _$actionInfo = _$FiltersStoreBaseActionController.startAction(
        name: 'FiltersStoreBase.updateSearch');
    try {
      return super.updateSearch(value);
    } finally {
      _$FiltersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSelectedMarkets(Market market, bool isSelected) {
    final _$actionInfo = _$FiltersStoreBaseActionController.startAction(
        name: 'FiltersStoreBase.changeSelectedMarkets');
    try {
      return super.changeSelectedMarkets(market, isSelected);
    } finally {
      _$FiltersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
selectedMarkets: ${selectedMarkets}
    ''';
  }
}
