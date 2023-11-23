import 'package:economiza_sc/stores/filters_store.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:economiza_sc/widgets/multi_select_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final _marketsStore = Modular.get<MarketsStore>();
  final _filtersStore = Modular.get<FiltersStore>();

  Future<void> _showMultiSelectModal() async {
    if (_marketsStore.markets.isNotEmpty) {
      await showDialog<List<String>>(
        context: context,
        builder: (context) {
          return const MultiSelectModal();
        },
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return _filtersStore.selectedMarkets.isEmpty
          ? ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
              onPressed: () => _showMultiSelectModal(),
              child: const Row(children: [
                Icon(Icons.filter_list, color: Colors.white),
                SizedBox(width: 5),
                Text('Filtros', style: TextStyle(color: Colors.white)),
              ]),
            )
          : ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () => _showMultiSelectModal(),
              child: Row(children: [
                Text(_filtersStore.selectedMarkets.length.toString(), style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 5),
                _filtersStore.selectedMarkets.length == 1
                    ? const Text(
                        'Mercado',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'Mercados',
                        style: TextStyle(color: Colors.white),
                      )
              ]),
            );
    });
  }
}
