import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class APIRepo {
  Future<Map?> getAllProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        return {'data': response.body};
      }
    } catch (e) {}
    return null;
  }
}
