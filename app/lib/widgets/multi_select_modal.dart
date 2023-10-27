import 'package:anotei/stores/filters_store.dart';
import 'package:anotei/stores/markets_store.dart';
import 'package:anotei/stores/products_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MultiSelectModal extends StatefulWidget {
  const MultiSelectModal({Key? key}) : super(key: key);

  @override
  State<MultiSelectModal> createState() => _MultiSelectModalState();
}

class _MultiSelectModalState extends State<MultiSelectModal> {
  final filtersStore = Modular.get<FiltersStore>();
  final marketsStore = Modular.get<MarketsStore>();
  final productsStore = Modular.get<ProductsStore>();

  void clearSelection() {
    filtersStore.selectedMarketIds.clear();
    filtersStore.selectedMarketNames.clear();
    Navigator.pop(context);
  }

  void submitSelection() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AlertDialog(
        title: const Text('Selecione as opções desejadas'),
        content: SingleChildScrollView(
          child: ListBody(
            children: marketsStore.markets
                .map((item) => CheckboxListTile(
                      value: filtersStore.selectedMarkets.contains(item),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          filtersStore.changeSelectedMarkets(item, newValue);
                          filtersStore.changeSelectedMarketIds(item.id, newValue);
                          print(productsStore.products.length);
                        }
                      },
                      title: Text(item.name),
                    ))
                .toList(),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: clearSelection,
            child: const Text('Limpar Seleção'),
          ),
          ElevatedButton(
            onPressed: submitSelection,
            child: const Text('Confirmar'),
          ),
        ],
      );
    });
  }
}
