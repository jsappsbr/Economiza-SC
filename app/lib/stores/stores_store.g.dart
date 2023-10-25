// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoresStore on StoresStoreBase, Store {
  late final _$storesAtom =
      Atom(name: 'StoresStoreBase.stores', context: context);

  @override
  ObservableList<store.Store> get stores {
    _$storesAtom.reportRead();
    return super.stores;
  }

  @override
  set stores(ObservableList<store.Store> value) {
    _$storesAtom.reportWrite(value, super.stores, () {
      super.stores = value;
    });
  }

  late final _$fetchStoresAsyncAction =
      AsyncAction('StoresStoreBase.fetchStores', context: context);

  @override
  Future<List<store.Store>> fetchStores(String search) {
    return _$fetchStoresAsyncAction.run(() => super.fetchStores(search));
  }

  late final _$StoresStoreBaseActionController =
      ActionController(name: 'StoresStoreBase', context: context);

  @override
  List<String> extractStoreNames(List<store.Store> stores) {
    final _$actionInfo = _$StoresStoreBaseActionController.startAction(
        name: 'StoresStoreBase.extractStoreNames');
    try {
      return super.extractStoreNames(stores);
    } finally {
      _$StoresStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stores: ${stores}
    ''';
  }
}
