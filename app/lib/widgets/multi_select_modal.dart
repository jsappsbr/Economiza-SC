import 'package:flutter/material.dart';

class MultiSelectModal extends StatefulWidget {
  const MultiSelectModal({Key? key, required this.itemList}) : super(key: key);

  final List<String> itemList;

  @override
  State<MultiSelectModal> createState() => _MultiSelectModalState();
}

class _MultiSelectModalState extends State<MultiSelectModal> {

  final List<String> _selectedStores = [];

  void changeSelection(String item, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedStores.add(item);
      } else {
        _selectedStores.remove(item);
      }
    });
  }

  void cancelSelection() {
    Navigator.pop(context, null); 
  }

  void submitSelection() {
    Navigator.pop(context, _selectedStores); 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecione as opções desejadas'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.itemList
              .map((item) => CheckboxListTile(
                    value: _selectedStores.contains(item),
                    onChanged: (isSelected) {
                      changeSelection(item, isSelected!);
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
  }
}