import 'package:equatable/equatable.dart';
import 'package:flutter_mobel_test/models/products.dart';

abstract class ProductLoadEvent {
  const ProductLoadEvent();
}

class LoadProducts extends ProductLoadEvent{

}