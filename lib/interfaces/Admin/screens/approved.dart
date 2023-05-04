
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../Modules/Product.dart';
import '../../../ProductDetail.dart';
import 'drawer.dart';
//import 'package:app_drawer/screens/product.dart';

//import 'package:app_drawer/utilis/trimName.dart';
import '../widgets/utilwidgets.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart' as Constants;

class ApprovedProducts extends StatefulWidget {
  @override
  _ApprovedProductsState createState() => _ApprovedProductsState();
}

class _ApprovedProductsState extends State<ApprovedProducts> {

  List<Product> listProduct = [];

  Future<void> getProducts() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('products').get();

    listProduct = snapshot.docs.map((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      return Product(
        name: data!['name'],
        description: data!['description'],
        image: data!['image'],
        category: data!['category'],
        publication_date: data!['publication_date'],
      );
    }).toList();
  }

  List<Product> get _listProduct => listProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
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
                          child: getApprovedProducts(product),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetail(product: product)),
                              );
                            });
                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 330,
                      ));
                }),
    );

    // TODO: implement build
    throw UnimplementedError();
  }
}

Widget getApprovedProducts(Product product){
  return Card(
    color: Colors.grey[300],
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 2,
        color: Colors.deepPurple.shade300,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 500,
      width: 500,
      child: Column(
        children: [
          ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.description),
                Text(product.category),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}