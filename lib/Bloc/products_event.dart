import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  @override
  List<Object> get props => [];
}

class DeleteProduct extends ProductEvent {
  const DeleteProduct(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}
