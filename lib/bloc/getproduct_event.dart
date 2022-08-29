import 'package:equatable/equatable.dart';

abstract class GetProductEvent extends Equatable {
  const GetProductEvent();
  @override
  List<Object> get props => [];
}

class GetProductsList extends GetProductEvent{}
