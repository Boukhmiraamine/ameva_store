// import 'package:app11/interfaces/Admin/Admin_Screen.dart';
import 'package:app11/interfaces/Admin/Admin_Screen.dart';
import 'package:app11/profile.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../Interfaces/About.dart';
import '../Interfaces/Profile.dart';
import '../Interfaces/Home.dart';
import '../Interfaces/Category.dart';
import '../interfaces/AddProduct.dart';
import 'interfaces/Admin/Admin_Screen.dart';
// import 'interfaces/Admin/waiting_products.dart';

class FirstInterface extends StatefulWidget {
  const FirstInterface({Key? key}) : super(key: key);
  @override
  State<FirstInterface> createState() => _FirstInterfaceState();
}



var _interfaces = [Home(), ProfileScreen(),AddProductPage(), About(),AdminScreen()];


int _currentIndex = 0;


class _FirstInterfaceState extends State<FirstInterface> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          //fixedColor: Colors.grey[300],
          //type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepPurple.shade300,
          color: Colors.deepPurple,
          animationDuration:Duration(milliseconds: 300) ,
          index: _currentIndex,
          height: 55,
          onTap: onTap,
          items: [
          /*  CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined),
              label: 'Home',
            ),*/
           /* Icon(Icons.home,color: Colors.white,),
            Icon(Icons.person ,color: Colors.white,),
            Icon(Icons.category_outlined,color: Colors.white,),
            Icon(Icons.help,color: Colors.white,),*/
            Icon(Icons.home,color: Colors.white,),
            Icon(Icons.person ,color: Colors.white,),
            Icon(Icons.add,color: Colors.white,size: 35,),
            Icon(Icons.help,color: Colors.white,),
            Icon(Icons.accessibility_new,color: Colors.white,),
            /*BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person ,),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined,),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help,),
              label: 'About',
            ),*/
          ],
        ),
        body: _interfaces[_currentIndex],
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

