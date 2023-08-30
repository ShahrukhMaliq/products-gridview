

import 'package:bloc/bloc.dart';
import 'package:flutter_mobel_test/Bloc/products_event.dart';
import 'package:flutter_mobel_test/models/products.dart';

import 'products_state.dart';

class ProductBloc extends Bloc<ProductLoadEvent,ProductState>{
  ProductBloc() : super(ProductLoading());

 ProductState get initialState => ProductLoading(); 

  @override
  Stream<ProductLoaded> mapEventToState(ProductLoadEvent event) async*{

      if(event is LoadProducts){
      final List<Product> products=await fetchProducts();
      yield ProductLoaded(products);
      }
  }

//should be done outside BLoC preferably in a sperate class communicating with API
Future<List<Product>> fetchProducts() async {
    return Product.generateFakeProducts();
  }
}