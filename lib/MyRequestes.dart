import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRequestes extends StatefulWidget {
  @override
  _MyRequestesState createState() => _MyRequestesState();
}

class _MyRequestesState extends State<MyRequestes> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('exchanges').snapshots(),
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

            return ListTile(
              title: Text(exchangeData['proposerProductName']),
              subtitle: Text(exchangeData['targetProductName']),
              trailing: Text(exchangeData!['status']),
            );
          },
        );
      },
    );
  }
}
