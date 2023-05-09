import 'package:app11/Modules/Product.dart';
import 'package:app11/MyProductsOnly.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget ProductItem(BuildContext context, Product product) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  return Card(
    elevation: 10.0,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black45),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: NetworkImage(
                    product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Category: #${product.category}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: firestore.collection('products').doc(product.id).get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('Loading...');
                        }

                        var data = snapshot.data!.data() as Map<String, dynamic>;
                        var userId = data['user_id'];

                        return FutureBuilder<DocumentSnapshot>(
                          future: firestore.collection('users').doc(userId).get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('Loading...');
                            }

                            var userData = snapshot.data!.data() as Map<String, dynamic>;
                            var firstName = userData['first name'];
                            var lastname = userData['last name'];

                            return Text(
                              "added by : $firstName $lastname",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        );
                      },
                    ),


                    Row(
                      children: [
                        Text(
                          "",
                          style: TextStyle(fontSize: 19),
                        ),
                        /*  Text(
                          "${Product.category} ",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Flexible(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepPurple.shade300),
              ),
              onPressed: () {
                print("****************************************");
                print("..${product.id}");
                print("****************************************");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProductsOnly(targetProduct:product)),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.send),
                  ),
                  Text("exchange", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
