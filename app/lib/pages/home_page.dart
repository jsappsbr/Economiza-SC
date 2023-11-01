import 'package:anotei/stores/filters_store.dart';
import 'package:anotei/stores/markets_store.dart';
import 'package:anotei/stores/products_store.dart';
import 'package:anotei/widgets/filter_button.dart';
import 'package:anotei/widgets/popup_menu_widget.dart';
import 'package:collection/collection.dart';
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
  final _filtersStore = Modular.get<FiltersStore>();
  final _marketsStore = Modular.get<MarketsStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _productsStore.fetchProducts();
    _marketsStore.fetchMarkets();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(
        () => _scrollController.position.pixels >= (0.9 * _scrollController.position.maxScrollExtent) ? _productsStore.fetchProducts() : null);

    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Anotei'),
          ),
          actions: const [
            CustomPopUpMenu(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _productsStore.fetchProducts,
          child: const Icon(Icons.search),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Digite sua busca'),
                      onChanged: _filtersStore.updateSearch,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const FilterButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _productsStore.products.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < _productsStore.products.length) {
                      final product = _productsStore.products[index];
                      final market = _marketsStore.markets.firstWhereOrNull((market) => market.id == product.marketId);
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "R\$ ${product.price.toStringAsFixed(2)}",
                                    style: const TextStyle(color: Colors.green, fontSize: 14),
                                  ),
                                ],
                              ),
                              Text(market?.name ?? ''),
                              Image.network(product.picture),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      );
    });
  }
}
