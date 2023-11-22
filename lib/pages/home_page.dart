import 'package:economiza_sc/stores/filters_store.dart';
import 'package:economiza_sc/stores/markets_store.dart';
import 'package:economiza_sc/stores/products_store.dart';
import 'package:economiza_sc/widgets/expand_button.dart';
import 'package:economiza_sc/widgets/filter_button.dart';
import 'package:economiza_sc/widgets/popup_menu_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _productsStore.initScrollController();
    _productsStore.fetchProducts();
    _marketsStore.fetchMarkets();
  }

  @override
  void dispose() {
    super.dispose();
    _productsStore.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/logo_simple_economiza.png'),
          leadingWidth: 50,
          title: const Text('Economiza SC', style: TextStyle(color: Colors.white)),
          actions: const [
            CustomPopUpMenu(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _productsStore.cleanProductSelection,
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
                      decoration: const InputDecoration(hintText: 'Digite o nome de um produto'),
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
                  controller: _productsStore.scrollController,
                  itemCount: _productsStore.products.length < _productsStore.productsPerPage
                      ? _productsStore.products.length
                      : _productsStore.products.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < _productsStore.products.length) {
                      final product = _productsStore.products[index];
                      final market = _marketsStore.markets.firstWhereOrNull((market) => market.id == product.marketId);
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(product.picture, height: 120, width: 120),
                                    ExpandButton(product: product),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.name,
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "R\$ ${product.price.toStringAsFixed(2)}",
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                                    ),
                                    Text(market?.name ?? '', style: const TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  }),
            ),
            _productsStore.productsLoading ? const LinearProgressIndicator(color: Colors.grey, backgroundColor: Colors.white60) : Container(),
          ],
        ),
      );
    });
  }
}
