import 'package:ecommerceapp/models/new_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider {
  Future<List<Product>?> getProducts() async {
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json);
    }
  }

//getting the product by category
  Future<List<Product>> getProductByCategoty(String categoryName) async {
    var uri =
        Uri.parse('https://fakestoreapi.com/products/category/$categoryName');
    var response = await http.get(uri);

    var json = response.body;
    return productsFromJson(json);
  }

//getting the products by the id of the product
  Future<Product> getProductById(int productID) async {
    var uri = Uri.parse('https://fakestoreapi.com/products/$productID');
    var response = await http.get(uri);
    var jsonres = response.body;
    Product item = Product.fromJson(json.decode(jsonres));
    return item;
  }
}
