import 'package:economiza_sc/models/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsService {
  Future<List<Product>> search(String search, int page, int perPage, {List<int>? marketIds}) async {
    final api = Modular.get<Dio>();

    final response = await api.post('/products/search', data: {
      'search': search,
      'market_ids': marketIds,
      'page': page,
      'per_page': perPage,
    });

    final data = response.data as Map<String, dynamic>;
    final rawProducts = data['data'] as List<dynamic>;

    return rawProducts.map((e) => Product.fromMap(e)).toList();
  }
}
