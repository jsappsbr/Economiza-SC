// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MarketsStore on MarketsStoreBase, Store {
  late final _$marketsAtom =
      Atom(name: 'MarketsStoreBase.markets', context: context);

  @override
  ObservableList<Market> get markets {
    _$marketsAtom.reportRead();
    return super.markets;
  }

  @override
  set markets(ObservableList<Market> value) {
    _$marketsAtom.reportWrite(value, super.markets, () {
      super.markets = value;
    });
  }

  late final _$marketNamesAtom =
      Atom(name: 'MarketsStoreBase.marketNames', context: context);

  @override
  ObservableList<String> get marketNames {
    _$marketNamesAtom.reportRead();
    return super.marketNames;
  }

  @override
  set marketNames(ObservableList<String> value) {
    _$marketNamesAtom.reportWrite(value, super.marketNames, () {
      super.marketNames = value;
    });
  }

  late final _$marketIdsAtom =
      Atom(name: 'MarketsStoreBase.marketIds', context: context);

  @override
  ObservableList<int> get marketIds {
    _$marketIdsAtom.reportRead();
    return super.marketIds;
  }

  @override
  set marketIds(ObservableList<int> value) {
    _$marketIdsAtom.reportWrite(value, super.marketIds, () {
      super.marketIds = value;
    });
  }

  late final _$fetchMarketsAsyncAction =
      AsyncAction('MarketsStoreBase.fetchMarkets', context: context);

  @override
  Future fetchMarkets() {
    return _$fetchMarketsAsyncAction.run(() => super.fetchMarkets());
  }

  late final _$MarketsStoreBaseActionController =
      ActionController(name: 'MarketsStoreBase', context: context);

  @override
  dynamic extractMarketNames() {
    final _$actionInfo = _$MarketsStoreBaseActionController.startAction(
        name: 'MarketsStoreBase.extractMarketNames');
    try {
      return super.extractMarketNames();
    } finally {
      _$MarketsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic extractMarketIds() {
    final _$actionInfo = _$MarketsStoreBaseActionController.startAction(
        name: 'MarketsStoreBase.extractMarketIds');
    try {
      return super.extractMarketIds();
    } finally {
      _$MarketsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
markets: ${markets},
marketNames: ${marketNames},
marketIds: ${marketIds}
    ''';
  }
}
