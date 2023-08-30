
import '../models/products.dart';


abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {

 ProductLoaded(this.product);
  final List<Product> product;

ProductLoaded copyWith(
 {List<Product>? product,
 }){
  return ProductLoaded(
    product??this.product);
 }

@override
List<Object> get props =>[product];
}