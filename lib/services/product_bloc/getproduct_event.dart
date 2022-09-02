import 'package:equatable/equatable.dart';

abstract class GetProductEvent extends Equatable {
  const GetProductEvent();
  @override
  List<Object> get props => [];
}

class GetProductsList extends GetProductEvent {}

class GetProductById extends GetProductEvent {
  final int productID;
  const GetProductById({required this.productID});
}

class GetProductByCategory extends GetProductEvent {
  final String categoryName;
  const GetProductByCategory({required this.categoryName});
}
