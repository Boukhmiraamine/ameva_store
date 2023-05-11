import 'package:app11/MyProductsItem.dart';
import 'package:app11/ProductDetail.dart';
import 'package:app11/auth/SendRequestPage.dart';
import 'package:app11/interfaces/Admin/item_waiting_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Modules/Product.dart';

class MyProductsOnly extends StatefulWidget {

final Product targetProduct;
  const MyProductsOnly({Key? key ,required this.targetProduct}) : super(key: key);
  @override
  State<MyProductsOnly> createState() => _MyProductsOnlyState();
}
class _MyProductsOnlyState extends State<MyProductsOnly> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),



        body: Column(
          children:[
          Expanded(
            flex: 2,
            child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'My Products',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  // add more properties here as desired
                ),
              ),
            ),


          ),



            Expanded(
            flex: 20,

            child: StreamBuilder<QuerySnapshot>(



                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data!.docs
                      .map((doc) => Product.fromSnapshot(doc))
                      .toList();



                  return GridView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];

                        return GestureDetector(
                          child: MyProductsItem(product),
                          onTap: () {

                            setState(() {
                              print("Target Product: ${widget.targetProduct.name}");
                              final selectedProduct = Product(
                                id: product.id,
                                name: product.name,
                                description: product.description,
                                image: product.image,
                                category: product.category,
                                publication_date: product.publication_date,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SendRequestPage(product: selectedProduct,targetProduct: widget.targetProduct)),

                              );
                            });
                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 280,
                      ));
                }),
          ),
        ]),
      ),
    );
  }
}



