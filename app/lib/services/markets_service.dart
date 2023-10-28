import 'package:anotei/models/market.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MarketsService {

  Future<List<Market>> search() async {
    final api = Modular.get<Dio>();

    final response = await api.get('/stores');

    final data = response.data as List;

    return data.map((e) => Market.fromMap(e)).toList();
  }

}