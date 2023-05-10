import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailTargetUser extends StatefulWidget {


  @override
  _DetailTargetUserState createState() => _DetailTargetUserState();
}

class _DetailTargetUserState extends State<DetailTargetUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Confermation"),
        ),
        body: Column(
    children: [

      Text("detailssss")
        ],

      ));
  }
}
