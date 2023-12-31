
import 'dart:io';
import 'package:app11/mydrawer.dart';
import 'package:app11/popUpMenu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  String? firstname='';
  String? lastname='';
  String? email='';
  String? phonenumber='';
  String? adresse='';
  String profileImage='' ;



  Future _getdatafromdatabase() async {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists){
        setState((){
          firstname = snapshot.data()!['first name'];
          lastname = snapshot.data()!['last name'];
          email = snapshot.data()!['email'];
          phonenumber = snapshot.data()!['phone'];
          adresse = snapshot.data()!['adresse'];
          profileImage = snapshot.data()!['profileImageUrl'];
        });
        // final profileImageUrl = snapshot.data()!['profileImageUrl'];
      }
    });
  }
  @override
  void initState(){
    super.initState();
    _getdatafromdatabase();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: const Text('Profile'),
          ),
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return PopUpMenu();
          //   },
          // ),
          actions: [
            PopUpMenu()
          ],
        ),
        // drawer: Mydrawer(),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurple.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                          radius: 60.0,

                          // backgroundImage: NetworkImage("https://i.ytimg.com/vi/JXMIpHDgb2A/maxresdefault.jpg"),
                    backgroundImage: NetworkImage(profileImage??""),
                 ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    firstname! +' '+ lastname!,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      email!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      phonenumber!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Adresse',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      adresse!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
