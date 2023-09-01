import 'package:bloc/bloc.dart';
import 'package:flutter_mobel_test/Bloc/products_event.dart';
import 'package:flutter_mobel_test/enums/loading_status.dart';
import 'package:flutter_mobel_test/models/products.dart';

import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsFromDb(event, state);
    }
    if (event is DeleteProduct) {
      yield* deleteProduct(event, state);
    }
  }

  Stream<ProductState> deleteProduct(
      DeleteProduct event, ProductState state) async* {
    final List<Product> products = List.from(state.product!);

    if (event.index >= 0 && event.index < products.length) {
      products.removeAt(event.index); // Remove the item if the index is valid
    }
    yield state.copyWith(
        product: products, status: LoadingStatus.success);
  }

  Stream<ProductState> _mapLoadProductsFromDb(
      ProductEvent event, ProductState state) async* {
    List<Product> products = [];
    yield state.copyWith(
        product: products, status: LoadingStatus.loading);
    products = await fetchProducts();
    yield state.copyWith(
        product: products, status: LoadingStatus.success);
  }

  //should be done outside BLoC preferably in a sperate class communicating with API
  Future<List<Product>> fetchProducts() async {
    return Product.generateFakeProducts();
  }
}
