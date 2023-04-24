import 'package:flutter/material.dart';

class Product {
  var id;
  var price;
  var decription;
  var name;
  var image;
  var category;
  //var quantity;

  Product({
    required this.decription,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    this.id,


    /*required this.quantity*/
  });
}

List<Product>demoProducts = [
  Product(
      id: 1,
      decription: "In the wake of a personal tragedy, four women face the past, their futures, and each other in a novel of broken ties and healing by the Amazon Charts bestselling author of When We Believed in Mermaids.",
      image: AssetImage("images/book.jpg"),
      name: "This Place of Wonder",
      price: "40 DH",
      category:""
  ),
  Product(
      id: 2,
      decription: "Introducing Surface Laptop 4 the most elegant and powerful Surface Laptop 4 ever. Surface Laptop 4 retains its iconic design and accomplishes tasks with style, performance, and speed. Be confident you’ll show up clearly with an HD front-facing camera and studio mics or immerse yourself in a cinematic experience with Dolby Atmos® audio. Surface Laptop 4 now has more choice than ever with two keyboard finishes, rich colors, and your choice of an 11th Gen Intel® Core™ or an exclusive AMD Ryzen™ Microsoft Surface® Edition processor in either 13.5” or 15” sizes. From the kitchen table to the office, the coffee shop and to the classroom, Surface Laptop 4 brings you the perfect balance of style, multitasking speed, and up to 19 hours1 of battery lifei.",
      image: AssetImage("images/laptop.webp"),
      name: "Microsoft Surface Laptop 4",
      price: "2000 DH",
      category:""
  ),
  Product(
      id: 3,
      decription: "The knit upper in these sport shoes allows breathability for the user. This allows regular airflow to keep the feet dry and fresh throughout the day.",
      image: AssetImage("images/shoes.jpg"),
      name: "Zixer Men's Korean Style",
      price: "100 DH",
      category:""
  ),
];