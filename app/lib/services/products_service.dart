import 'package:anotei/models/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsService {
  Future<List<Product>> search(String search, {List<int>? marketIds}) async {
    final api = Modular.get<Dio>();

    final response = await api.post('/products/search', data: {
      'search': search,
      'store_ids': marketIds,
    });

    final data = response.data as List;

    return data.map((e) => Product.fromMap(e)).toList();
  }
}
