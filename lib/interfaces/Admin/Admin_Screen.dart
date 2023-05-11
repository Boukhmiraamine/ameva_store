import 'package:app11/Interfaces/Home.dart';

import 'package:app11/interfaces/Admin/screens/approved.dart';

import 'package:app11/interfaces/Admin/screens/home_screen.dart';

import 'package:app11/interfaces/Admin/screens/users.dart';
import 'package:app11/interfaces/Admin/waiting_products.dart';
import 'package:app11/main.dart';
import 'package:flutter/material.dart';

import '../../login.dart';
import '../Category.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var i;
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer App',
      theme: ThemeData(
          primaryColor: Colors.deepPurple,

      ),
      home: HomeScreen(),
      routes:{
        "/home": (BuildContext context) => HomeScreen(),
        "/waitingproduct": (BuildContext context) => waiting_products(),


        "/approved": (BuildContext context) => ApprovedProducts(),

        "/users": (BuildContext context) => UserScreen(),
        "/logout":(BuildContext context)=>Login(),

      },
    );
    return app;
  }
}
