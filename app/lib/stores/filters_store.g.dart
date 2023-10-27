// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FiltersStore on FiltersStoreBase, Store {
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

  late final _$selectedMarketNamesAtom =
      Atom(name: 'FiltersStoreBase.selectedMarketNames', context: context);

  @override
  ObservableList<String> get selectedMarketNames {
    _$selectedMarketNamesAtom.reportRead();
    return super.selectedMarketNames;
  }

  @override
  set selectedMarketNames(ObservableList<String> value) {
    _$selectedMarketNamesAtom.reportWrite(value, super.selectedMarketNames, () {
      super.selectedMarketNames = value;
    });
  }

  late final _$selectedMarketIdsAtom =
      Atom(name: 'FiltersStoreBase.selectedMarketIds', context: context);

  @override
  ObservableList<int> get selectedMarketIds {
    _$selectedMarketIdsAtom.reportRead();
    return super.selectedMarketIds;
  }

  @override
  set selectedMarketIds(ObservableList<int> value) {
    _$selectedMarketIdsAtom.reportWrite(value, super.selectedMarketIds, () {
      super.selectedMarketIds = value;
    });
  }

  late final _$FiltersStoreBaseActionController =
      ActionController(name: 'FiltersStoreBase', context: context);

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
  dynamic extractSelectedMarketNames() {
    final _$actionInfo = _$FiltersStoreBaseActionController.startAction(
        name: 'FiltersStoreBase.extractSelectedMarketNames');
    try {
      return super.extractSelectedMarketNames();
    } finally {
      _$FiltersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic extractMarketIds() {
    final _$actionInfo = _$FiltersStoreBaseActionController.startAction(
        name: 'FiltersStoreBase.extractMarketIds');
    try {
      return super.extractMarketIds();
    } finally {
      _$FiltersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedMarkets: ${selectedMarkets},
selectedMarketNames: ${selectedMarketNames},
selectedMarketIds: ${selectedMarketIds}
    ''';
  }
}
