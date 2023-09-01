import 'package:equatable/equatable.dart';
import 'package:flutter_mobel_test/enums/loading_status.dart';

import '../models/products.dart';



class ProductState extends Equatable {
  const ProductState(
      {this.product, this.status = LoadingStatus.loading});
  final List<Product>? product;
  final LoadingStatus status;
  bool get isLoading => status == LoadingStatus.loading;
  bool get issucess => status == LoadingStatus.success;
  ProductState copyWith(
      {List<Product>? product, LoadingStatus? status}) {
    return ProductState(
        product: product ?? this.product, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [product, status];
}
