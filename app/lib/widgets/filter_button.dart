import 'package:anotei/stores/filters_store.dart';
import 'package:anotei/stores/markets_store.dart';
import 'package:anotei/widgets/multi_select_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final marketsStore = Modular.get<MarketsStore>();
  final filtersStore = Modular.get<FiltersStore>();

  @override
  void initState() {
    super.initState();
    _loadObservables();
  }

  Future<void> _loadObservables() async {
    await marketsStore.fetchMarkets();
    await marketsStore.extractMarketNames();
  }

  Future<void> _showMultiSelectModal() async {
    if (marketsStore.marketNames.isNotEmpty) {
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
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
      onPressed: () => _showMultiSelectModal(),
      child: const Row(children: [
        Icon(Icons.filter_list),
        Text('Filtros'),
      ]),
    );
  }
}
