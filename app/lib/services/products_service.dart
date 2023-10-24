import 'package:anotei/models/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsService {
  Future<List<Product>> search(String search) async {
    final api = Modular.get<Dio>();

    final response = await api.get('/products', queryParameters: {
      'search': search,
    });

    final data = response.data as List;

    return data.map((e) => Product.fromMap(e)).toList();
  }

  Future<List<Product>> filterByStoreIds(List<int> storeIds, String search) async {
    final api = Modular.get<Dio>();
    
    final response = await api.get('/products', queryParameters: {
      'store_ids': storeIds, 
      'search': search,
    });

    final data = response.data as List;

    return data.map((e) => Product.fromMap(e)).toList();
  }
}
