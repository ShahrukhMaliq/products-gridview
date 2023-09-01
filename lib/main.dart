import 'package:flutter/material.dart';
import 'package:flutter_mobel_test/appbar.dart';
import 'package:flutter_mobel_test/bloc/products_bloc.dart';
import 'package:flutter_mobel_test/bloc/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/products_event.dart';
import 'models/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ProductBloc()..add(LoadProducts()),
        child: const ProductList(),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: MyAppBar.create(
            context, "","Card Deletion Simple App",false,[]),
          
        resizeToAvoidBottomInset: false,
        body: 
   BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) => previous.product != current.product,
        builder: (context, state) {
          if (state.isLoading) {
            return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()));
          } else if (state.issucess) {
            return Center(
                child: state.product!.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: TextButton(
                                child: const Text("Load Products?"),
                                onPressed: () => context
                                    .read<ProductBloc>()
                                    .add(LoadProducts())),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              // number of items per row
                              crossAxisCount: 3,
                              // vertical spacing between the items
                              mainAxisSpacing: 10,
                              // horizontal spacing between the items
                              crossAxisSpacing: 10,

                              // number of items in your list
                            ),
                            itemCount: state.product!.length,
                            itemBuilder: (context, index) {
                              return ProductListItem(
                                  product: state.product![index], index: index);
                            })));
          } else {
            return Container();
          }
        }));
  }
}

class ProductListItem extends StatelessWidget {
  final Product product;
  final int index;
  const ProductListItem(
      {super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () async {
            context.read<ProductBloc>().add(DeleteProduct(index));
          },
          child: Column(children: [
            ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/unnamed.jpg'),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.grey, // Set divider color as desired
                      thickness: 1.0, // Set divider thickness as desired
                      height: 10.0, // Set divider height as desired
                    ),
                  ],
                ),
                subtitle: Column(children: [Text(product.description)])),
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: const Text(
                  "To give padding from the top to a ListTile, you can use the contentPadding property of the ListTile. Here's how to do it:"),
            ),
          ])),
    );
  }
}
