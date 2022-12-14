import 'package:ecommerceapp/repository/new_repository.dart';
import 'package:ecommerceapp/services/product_bloc/getproduct_event.dart';
import 'package:ecommerceapp/services/product_bloc/getproduct_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetProductsBloc extends Bloc<GetProductEvent, GetProductState> {
  GetProductsBloc() : super(Productinitial()) {
    final NewApiRepository apiRepository = NewApiRepository();

    
    on<GetProductsList>((event, emit) async {
      try {
        emit(ProductLoading());
        final productList = await apiRepository.fetchAllProducts();
        emit(ProductLoaded(productList!));
        // if (productList.error != null) {
        //   emit(ProductError(productList.error));
        // }
      } on NetworkError {
        emit(
            const ProductError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
