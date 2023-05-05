import 'package:app11/MyProductsItem.dart';
import 'package:app11/ProductDetail.dart';
import 'package:app11/auth/SendRequestPage.dart';
import 'package:app11/interfaces/Admin/item_waiting_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Modules/Product.dart';

class MyProductsOnly extends StatefulWidget {


  const MyProductsOnly({Key? key}) : super(key: key);
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
            flex: 1,
            child:Text("MyProcucts")

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SendRequestPage(product: product)),
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



