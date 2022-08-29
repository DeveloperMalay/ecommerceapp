import 'package:ecommerceapp/models/get_all_products_model.dart';
import 'package:ecommerceapp/networking/api_provider.dart';

class ApiRepository {
  final _provider = ProductApiProvider();
  Future<AllProducts> fetchAllProducts() {
    return _provider.getAllProducts();
  }
}

class NetworkError extends Error {}
