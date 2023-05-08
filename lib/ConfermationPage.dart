import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfermationPage extends StatefulWidget {
  @override
  _ConfermationPageState createState() => _ConfermationPageState();
}

class _ConfermationPageState extends State<ConfermationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Confermation"),
        ),
        body: Column(

          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('exchanges')
                      .where('targetUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      FirebaseFirestore.instance
                          .collection('exchanges')
                          .doc(doc.id)
                          .update({'reponse': 'je confirme'});
                    });
                  });
                },
                child: Row(
                  children: [Text("Conferme")],
                )),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('exchanges')
                      .where('targetUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      FirebaseFirestore.instance
                          .collection('exchanges')
                          .doc(doc.id)
                          .update({'reponse': 'je refuse'});
                    });
                  });
                },
                child: Row(
                  children: [Text("refuse")],
                ))
          ],
        ));
  }
}
