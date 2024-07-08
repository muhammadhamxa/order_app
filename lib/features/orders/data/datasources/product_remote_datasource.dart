import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

abstract class ProductRemoteDataSource {
  Future<Map<String, dynamic>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getProducts() async {
    final response =
        await client.get(Uri.parse('https://app.giotheapp.com/api-sample/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return jsonMap;
    } else {
      throw ServerException();
    }
  }
}
