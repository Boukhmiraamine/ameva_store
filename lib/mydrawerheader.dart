import 'package:flutter/material.dart';
import 'package:app11/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyDrawerHeader extends StatefulWidget {
  MyDrawerHeader({Key? key}) : super(key: key);

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.deepPurple,
      width: double.infinity,
      //margin: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 100,
            decoration: BoxDecoration(
                //shape: BoxShape.circle,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Image.asset("assets/images/avatar.png")
          ),
          Text(
          ''+ user.email!,
            style: TextStyle(
                fontSize: 16,
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
