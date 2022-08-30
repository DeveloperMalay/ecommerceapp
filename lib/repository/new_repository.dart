import 'package:ecommerceapp/models/new_model.dart';
import 'package:ecommerceapp/networking/new_api_provider.dart';

class NewApiRepository {
  final _provider = ApiProvider();
  Future<List<Product>?> fetchAllProducts() {
    return _provider.getProducts();
  }

  Future<List<Product>?> fetchProductsByCategory() {
    return _provider.getProductByCategoty('categoryName');
  }

  Future<Product> fetchProductsByID() {
    return _provider.getProductById(1);
  }
}

class NetworkError extends Error {}
