import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfermationPage extends StatefulWidget {
  final String exchangeId;

  ConfermationPage({required this.exchangeId});

  @override
  _ConfermationPageState createState() => _ConfermationPageState();
}

class _ConfermationPageState extends State<ConfermationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmation"),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('exchanges')
            .doc(widget.exchangeId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Request",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8.0),


                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('products')
                          .doc(data['proposerProductId'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          var productData =
                          snapshot.data!.data() as Map<String, dynamic>;
                          var productImage = productData['image'];

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8, // Adjust the width to your liking
                            height: MediaQuery.of(context).size.width * 0.8, // Adjust the height to your liking
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(productImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),


                    SizedBox(height: 8.0),
                    Text(
                      "product: ${data['proposerProductName']}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Description: ${data['description']}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),

                    SizedBox(height: 4.0),
                    Text(
                      "Proposer User Name: ${data['proposerUserName']}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('exchanges')
                                .doc(widget.exchangeId)
                                .update({
                              'reponse': 'I accept the exchange',
                            });
                          },
                          icon: Icon(Icons.check),
                          label: Text("Confirm"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('exchanges')
                                .doc(widget.exchangeId)
                                .update({
                              'reponse': 'I refuse the exchange',
                            });
                          },
                          icon: Icon(Icons.cancel),
                          label: Text("Refuse"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
