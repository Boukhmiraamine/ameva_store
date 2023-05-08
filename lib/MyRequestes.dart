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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('exchanges').where('targetUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
              leading: Icon(Icons.person),
              title: Text((exchangeData as Map<String, dynamic>)['proposerProductName']),
              subtitle: Text((exchangeData as Map<String, dynamic>)['targetProductName']),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {

                });
              },
              selected: true, // Si le ListTile est sélectionné ou non
              enabled: false, // Si le ListTile est activé ou non
              dense: true, // Si le ListTile a une hauteur réduite ou non
              contentPadding: EdgeInsets.all(16.0), // Padding du contenu
              shape: RoundedRectangleBorder( // Bordure du ListTile
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(width: 1, color: Colors.grey),
              ),
            );
          },
        );
      },
    );
  }
}
