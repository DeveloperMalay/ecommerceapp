import 'package:ecommerceapp/models/new_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<List<Product>?> getProducts() async {
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json);
    }
  }
}