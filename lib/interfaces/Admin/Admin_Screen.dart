import 'package:app11/Interfaces/Home.dart';
import 'package:app11/interfaces/Admin/screens/add_category.dart';
import 'package:app11/interfaces/Admin/screens/add_sub.dart';
import 'package:app11/interfaces/Admin/screens/approved.dart';
import 'package:app11/interfaces/Admin/screens/category.dart';
import 'package:app11/interfaces/Admin/screens/home_screen.dart';
import 'package:app11/interfaces/Admin/screens/invalid.dart';
import 'package:app11/interfaces/Admin/screens/pending.dart';
import 'package:app11/interfaces/Admin/screens/sold.dart';
import 'package:app11/interfaces/Admin/screens/users.dart';
import 'package:app11/main.dart';
import 'package:flutter/material.dart';

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
          primaryColor: Colors.blue,

      ),
      home: HomeScreen(),
      routes:{
        "/home": (BuildContext context) => HomeScreen(),
        "/category": (BuildContext context) => CategoryAdmin(),
        "/addCat" : (BuildContext context) => AddCategory(),
        "/addSubCat": (BuildContext context) =>  AddSubCategory(),

        "/approved": (BuildContext context) => ApprovedProducts(),
        "/pending": (BuildContext context) =>  PendingProducts(),
        "/sold":(BuildContext context) => SoldProducts(),
        "/inactive":(BuildContext context) => InvalidProducts(),
        "/users": (BuildContext context) => User(),
        "/logout":(BuildContext context)=>Home(),

      },
    );
    return app;
  }
}
