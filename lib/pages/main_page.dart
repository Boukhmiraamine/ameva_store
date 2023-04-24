import 'package:app11/auth/auth_page.dart';
import 'package:app11/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirstInterface.dart';
import '../auth/HomePage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return FirstInterface();
          }
          else{
            return AuthPage();
          }
        },
      ),
    );
  }
}
