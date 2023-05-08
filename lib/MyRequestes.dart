import 'package:app11/ConfermationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRequestes extends StatefulWidget {
  @override
  _MyRequestesState createState() => _MyRequestesState();
}

class _MyRequestesState extends State<MyRequestes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("My Requests"),
    ),

      body :StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('exchanges')
          .where('targetUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final exchangeDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: exchangeDocs.length,
          itemBuilder: (context, index) {
            final exchangeDoc = exchangeDocs[index];
            final exchangeData = exchangeDoc.data();

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text((exchangeData as Map<String, dynamic>)['proposerProductName']),
                subtitle: Text((exchangeData as Map<String, dynamic>)['description']),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  setState(() {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfermationPage()),
                    );

                  });
                },
                selected: true, // Whether the ListTile is selected or not
                enabled: true, // Whether the ListTile is enabled or not
                dense: false, // Whether the ListTile has reduced height or not
              ),
            );
          },
        );
      },
    )
    );
  }
}
