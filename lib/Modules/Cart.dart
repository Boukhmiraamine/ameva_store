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

