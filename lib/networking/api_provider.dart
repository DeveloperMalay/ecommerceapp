import 'package:dio/dio.dart';
import 'package:ecommerceapp/models/get_all_products_model.dart';

class ProductApiProvider {
  final Dio dio = Dio();
  final String url = 'https://fakestoreapi.com/products';

  Future<AllProducts> getAllProducts() async {
    try {
      Response response = await dio.get(url);
      return AllProducts.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured:$error stackTrace:$stacktrace');
      return AllProducts.withError('Data not found');
    }

    // if (response.statusCode == 200) {
    //   return AllProducts.fromJson(response.data);
    // } else {
    //   throw Exception('Failed to load all the products');
    // }
  }
}
