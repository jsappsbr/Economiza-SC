import 'package:anotei/models/store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StoresService {

  Future<List<Store>> search() async {
    final api = Modular.get<Dio>();

    final response = await api.get('/stores');

    final data = response.data as List;

    return data.map((e) => Store.fromMap(e)).toList();
  }

}