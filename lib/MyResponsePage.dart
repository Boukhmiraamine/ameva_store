import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyResponsePage extends StatefulWidget {
  @override
  _MyResponsePagePageState createState() => _MyResponsePagePageState();
}

class _MyResponsePagePageState extends State<MyResponsePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('exchanges')
          .where('proposerUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final exchangeDocs = snapshot.data!.docs;

        if (exchangeDocs.isEmpty) {
          return Center(
            child: Column(
              children: [
                Text('You don\'t have any response'),
                Icon(Icons.error_outline,size: 20,color: Colors.deepPurple,)
              ],
            ),
          );
        }
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
                title: Text((exchangeData as Map<String, dynamic>)['targetUserName']),
                subtitle: Text((exchangeData as Map<String, dynamic>)['proposerProductName']),
                trailing: Text((exchangeData as Map<String, dynamic>)['reponse']),
                onTap: () {

                },
                selected: true, // Whether the ListTile is selected or not
                enabled: true, // Whether the ListTile is enabled or not
                dense: false, // Whether the ListTile has reduced height or not
              ),
            );
          },
        );
      },
    );
  }
}
