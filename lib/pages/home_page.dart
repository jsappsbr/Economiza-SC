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

  Size get size => MediaQuery.of(context).size;
  double get itemHeight => (size.height - kToolbarHeight - 24) / 2;
  double get itemWidth => size.width / 2;

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
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Image.asset('assets/images/logo_white.png'),
          ),
          leadingWidth: 35,
          title:
              const Text('Economiza SC', style: TextStyle(color: Colors.white)),
          actions: const [
            CustomPopUpMenu(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _productsStore.cleanProducts();
            _productsStore.fetchProducts();
          },
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: 'Digite o nome de um produto'),
                      onChanged: _filtersStore.updateSearch,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const FilterButton(),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: itemWidth / itemHeight,
                padding: const EdgeInsets.all(4),
                controller: _productsStore.scrollController,
                children: _productsStore.products.map((product) {
                  final productMarket = _marketsStore.markets.firstWhereOrNull(
                      (market) => market.id == product.marketId);

                  return SizedBox(
                    height: 600,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.labelMedium,
                            maxLines: 2,
                          ),
                          Expanded(
                            child: Image.network(
                              product.picture,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(
                            productMarket?.name ?? '',
                            style: Theme.of(context).textTheme.labelSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            _productsStore.productsLoading
                ? const LinearProgressIndicator(
                    color: Colors.grey, backgroundColor: Colors.white60)
                : Container(),
          ],
        ),
      );
    });
  }
}
