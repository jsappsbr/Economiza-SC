import 'package:economiza_sc/stores/filters_store.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:economiza_sc/stores/products_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MultiSelectModal extends StatefulWidget {
  const MultiSelectModal({super.key});

  @override
  State<MultiSelectModal> createState() => _MultiSelectModalState();
}

class _MultiSelectModalState extends State<MultiSelectModal> {
  final _filtersStore = Modular.get<FiltersStore>();
  final _marketsStore = Modular.get<MarketsStore>();
  final _productsStore = Modular.get<ProductsStore>();

  void _scrollToTop() {
    _productsStore.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _clearSelection() async {
    _productsStore.goToFirstPage();
    await Future.wait([
      _filtersStore.cleanSelectedMarkets(),
      _productsStore.cleanProducts(),
      _productsStore.fetchProducts(),
    ]);
    _closeModal();
    _scrollToTop();
  }

  void _submitSelection() async {
    _productsStore.goToFirstPage();
    await Future.wait([
      _productsStore.cleanProducts(),
      _productsStore.fetchProducts(),
    ]);
    _closeModal();
    _scrollToTop();
  }

  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Selecione as opções desejadas:',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
            ),
            const Spacer(),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                onPressed: _closeModal,
                icon: const Icon(Icons.clear, color: Colors.black),
                hoverColor: Colors.grey.shade300, 
              ),
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
