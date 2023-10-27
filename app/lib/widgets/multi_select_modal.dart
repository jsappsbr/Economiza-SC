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

  void _clearSelection() {
    filtersStore.selectedMarkets.clear();
    Navigator.pop(context);
  }

  void _submitSelection() async {
    productsStore.fetchProducts('', marketIds: filtersStore.extractMarketIds());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AlertDialog(
        title: const Text('Selecione as opções desejadas:'),
        content: SingleChildScrollView(
          child: ListBody(
            children: marketsStore.markets
                .map((item) => CheckboxListTile(
                      value: filtersStore.selectedMarkets.contains(item),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          filtersStore.changeSelectedMarkets(item, newValue);
                        }
                      },
                      title: Text(item.name),
                    ))
                .toList(),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
            onPressed: _clearSelection,
            child: const Text('Limpar Seleção'),
          ),
          ElevatedButton(
            onPressed: _submitSelection,
            child: const Text('Confirmar'),
          ),
        ],
      );
    });
  }
}
