import 'package:app11/Modules/Product.dart';
import 'package:flutter/material.dart';

class Cart {
  final Product product;
  final int numOfItems;
  Cart({required this.product,required this.numOfItems});

  double totalCount(double price){
    return price*this.numOfItems;
  }
}

//Demo data

List<Cart> demoCart = [
  Cart(product: demoProducts[0],numOfItems: 2),
  Cart(product: demoProducts[1],numOfItems: 3),
  Cart(product: demoProducts[2],numOfItems: 1),
];