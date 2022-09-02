import 'package:ecommerceapp/models/new_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetProductState extends Equatable {
  const GetProductState();
  @override
  List<Object> get props => [];
}

class Productinitial extends GetProductState {}

class ProductLoading extends GetProductState {}

class ProductLoaded extends GetProductState {
  final List<Product> allproducts;

  const ProductLoaded(this.allproducts);
}

class ProductError extends GetProductState {
  final String? message;
  const ProductError(this.message);
}
