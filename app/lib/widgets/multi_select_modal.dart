import 'package:anotei/stores/filters_store.dart';
import 'package:anotei/stores/markets_store.dart';
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

  @override
  void initState() {
    super.initState();
  }

  void cancelSelection() {
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
                      onChanged: (isSelected) {
                        filtersStore.changeSelectedMarketNames(item.name, isSelected!);
                        filtersStore.changeSelectedMarketIds(item.id, isSelected);
                        print(filtersStore.selectedMarketNames);
                        print(filtersStore.selectedMarketIds);
                      },
                      title: Text(item.name),
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
