import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  var id;
  var description;
  var name;
  var image;
  var category;
  var publication_date;

  //var quantity;

  Product({
    required this.description,
    required this.image,
    required this.name,
    required this.category,
    required this.publication_date,
    this.id,

  });
  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Product(
      id: snapshot.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      publication_date: data['publication_date'] ?? '',
    );
  }
}