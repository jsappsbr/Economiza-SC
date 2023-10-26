import 'package:anotei/stores/markets_store.dart';
import 'package:anotei/stores/products_store.dart';
import 'package:anotei/widgets/filter_button.dart';
import 'package:anotei/widgets/popup_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _productsStore = Modular.get<ProductsStore>();
  final marketsStore = Modular.get<MarketsStore>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productsStore.fetchProducts('', marketIds: marketsStore.marketIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home Page'),
        ),
        actions: const [
          CustomPopUpMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _productsStore.fetchProducts(_searchController.text);
        },
        child: const Icon(Icons.search),
      ),
      body: Column(
        children: [
          Observer(
            builder: (_) => Padding(
              padding: const EdgeInsets.fromLTRB(10,5,10,24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(hintText: 'Digite sua busca'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const FilterButton(),
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) => Expanded(
              child: ListView.builder(
                  itemCount: _productsStore.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = _productsStore.products[index];
                    return ListTile(
                      trailing: Text(
                        product.price.toString(),
                        style: const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(product.name),
                      subtitle: Image.network(product.picture),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
