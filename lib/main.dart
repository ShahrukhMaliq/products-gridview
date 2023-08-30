import 'package:flutter/material.dart';
import 'package:flutter_mobel_test/Bloc/products_bloc.dart';
import 'package:flutter_mobel_test/Bloc/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/products_event.dart';
import 'models/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  BlocProvider(
        create: (context) => ProductBloc()..add(LoadProducts()),
        child:const  ProductList(),
      ),
    );
  }
}
class ProductList extends StatelessWidget {
  const ProductList({super.key});
  @override
  Widget build(BuildContext context) {
  return BlocBuilder<ProductBloc,ProductState>(
   builder:(context,state) {
     if(state is ProductLoading){
        return const Center(child: CircularProgressIndicator());
       }
      else if(state is ProductLoaded){
      return ListView.builder(
      itemCount: state.product.length,
      itemBuilder: (context, index) {
      return ProductListItem(product: state.product[index]);
      });
    }
    else {
        return Container();
      }
    });

  }
}
class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(  
    child: ListTile(
    title: Text(product.title),
    subtitle: Text(product.description),
      
    ));
  }
}