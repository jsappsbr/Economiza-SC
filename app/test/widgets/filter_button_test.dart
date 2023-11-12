import 'package:economiza_sc/models/market.dart';
import 'package:economiza_sc/modules/app_module.dart';
import 'package:economiza_sc/stores/filters_store.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:economiza_sc/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final appModule = AppModule();

  setUpAll(() async {
    Modular.init(appModule);
  });

  group('FilterButton widget', () {
    testWidgets('FilterButton\'s color changes when market(s) are selected', (tester) async {
      final filtersStore = Modular.get<FiltersStore>();
      await tester.pumpWidget(
        const MaterialApp(
            home: Scaffold(
          body: FilterButton(),
        )),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      // The following "resolve" method is used to get the color value based on the current state of the widget
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).style!.backgroundColor!.resolve({}), Colors.grey);
      filtersStore.changeSelectedMarkets(Market(id: 0, name: 'Walmart', website: 'walmart.com'), true);
      await tester.pump();
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).style!.backgroundColor!.resolve({}), Colors.blue);
    });

    testWidgets('A modal is open when the user clicks on FilterButton', (tester) async {
      final marketsStore = Modular.get<MarketsStore>();
      final Market market = Market(id: 0, name: 'test', website: 'test.com.br');
      marketsStore.markets.add(market);

      await tester.pumpWidget(
        const MaterialApp(
            home: Scaffold(
          body: FilterButton(),
        )),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsWidgets);
    });
  });
}
