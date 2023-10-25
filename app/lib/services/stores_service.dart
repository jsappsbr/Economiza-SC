import 'package:anotei/models/store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StoresService {

  Future<List<Store>> search(String search) async {
    final api = Modular.get<Dio>();

    final response = await api.get('/stores', queryParameters: {
      'search': search,
    });

    final data = response.data as List;

    print('StoreService print is: $data');

    return data.map((e) => Store.fromMap(e)).toList();
  }

}