import 'package:economiza_sc/stores/filters_store.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TestModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<FiltersStore>(() => FiltersStore());
    i.addSingleton<MarketsStore>(() => MarketsStore());
    super.binds(i);
  }
}
