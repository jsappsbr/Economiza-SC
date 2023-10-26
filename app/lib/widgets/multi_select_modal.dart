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

  @override
  void initState() {
    super.initState();
  }

  void cancelSelection() {
    Navigator.pop(context, null);
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
            children: marketsStore.marketNames
                .map((item) => CheckboxListTile(
                      value: filtersStore.selectedMarketNames.contains(item),
                      onChanged: (isSelected) {
                        filtersStore.changeSelectedMarketNames(item, isSelected!);
                      },
                      title: Text(item),
                    ))
                .toList(),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: cancelSelection,
            child: const Text('Cancelar'),
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
