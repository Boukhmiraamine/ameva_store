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

        body :Column(
          children: [

            ElevatedButton(onPressed: (){


            }, child: Row(children: [Text("Conferme")],)),
            ElevatedButton(onPressed: (){


            }, child: Row(children: [Text("refuse")],))
          ],
        )
    );
  }
}
