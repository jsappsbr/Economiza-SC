import 'package:anotei/stores/stores_store.dart';
import 'package:anotei/widgets/multi_select_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:anotei/models/store.dart' as store;

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {

  final storesStore = Modular.get<StoresStore>();
  List<store.Store> storeList = [];
  List<String> storeNames = [];

  void _loadStoreData() {
    storesStore.fetchStores().then((stores) {
      setState(() {
        storeList = stores;
        storeNames = storesStore.extractStoreNames(storeList);
      });
    });
  }

  Future<void> _showMultiSelectModal() async {
    if (storeNames.isNotEmpty) {
      await showDialog<List<String>>(
        context: context,
        builder: (context) {
          return MultiSelectModal(itemList: storeNames);
        },
      ).then((selectedItems) {
        if (selectedItems != null) {
          print('Selected items: $selectedItems'); 
        }
      });
    } else {
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStoreData();
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
