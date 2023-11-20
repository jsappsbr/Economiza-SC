import 'package:economiza_sc/models/product.dart';
import 'package:economiza_sc/modules/app_module.dart';
import 'package:economiza_sc/services/products_service.dart';
import 'package:economiza_sc/stores/products_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ProductsService>()])
import 'products_store_test.mocks.dart';

void main() {
  final mockProductsService = MockProductsService();

  setUp(() {
    reset(mockProductsService);
    Modular.init(AppModule());
    Modular.replaceInstance<ProductsService>(mockProductsService);
  });

  tearDown(() {
    Modular.destroy();
  });

  group('Products Store', () {
    group('fetchProducts method', () {
      test('products are properly fetched', () async {
        final List<Product> mockedProducts = [
          Product(
            id: 1,
            name: 'Product 1',
            marketId: 1,
            price: 1,
            picture: '',
            link: '',
            sku: '',
          )
        ];

        when(mockProductsService.search('', 1, 20, marketIds: [])).thenAnswer((_) async => mockedProducts);

        final productsStore = ProductsStore();
        await productsStore.fetchProducts();

        expect(productsStore.products, containsAll(mockedProducts));
        expect(productsStore.page, 2);
        expect(productsStore.productsLoading, false);
        verify(mockProductsService.search('', 1, 20, marketIds: [])).called(1);
      });
      test('products are not fetched successfully', () async {
        when(mockProductsService.search('', 1, 20, marketIds: [])).thenThrow(Exception());

        final productsStore = ProductsStore();
        await productsStore.fetchProducts();

        expect(productsStore.products, isEmpty);
        expect(productsStore.page, 1);
        expect(productsStore.productsLoading, false);
        verify(mockProductsService.search('', 1, 20, marketIds: [])).called(1);
      });
    });
  });
}
