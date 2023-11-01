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
  final _filtersStore = Modular.get<FiltersStore>();
  final _marketsStore = Modular.get<MarketsStore>();
  final _productsStore = Modular.get<ProductsStore>();

  void _clearSelection() {
    _productsStore.page = 1;
    _filtersStore.selectedMarkets.clear();
    _closeModal();
  }

  void _submitSelection() async {
    _productsStore.page = 1;
    _productsStore.fetchProducts();
    _closeModal();
  }

  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AlertDialog(
        title: Row(
          children: [
            const Text(
              'Selecione as opções desejadas:',
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            IconButton(
              onPressed: _closeModal,
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: _marketsStore.markets
                .map((item) => CheckboxListTile(
                      value: _filtersStore.selectedMarkets.contains(item),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          _filtersStore.changeSelectedMarkets(item, newValue);
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
