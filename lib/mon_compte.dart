

import 'package:app11/Interfaces/Profile.dart';
import 'package:app11/info_perso.dart';
import 'package:app11/profile.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:app11/aide.dart';
import 'package:app11/commandes.dart';
import 'package:app11/info_bank.dart';
import 'package:app11/info_perso.dart';
import 'package:app11/mydrawer.dart';
import 'package:app11/mydrawerheader.dart';


class MonCompte extends StatefulWidget {
  const MonCompte({Key? key}) : super(key: key);

  @override
  State<MonCompte> createState() => MonCompteState();
}

class MonCompteState extends State<MonCompte> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '1',
      routes: {
        '1' : (context) =>  InfoPerso(),
        '2' : (context) => InfoBank(),
        '3' : (context) => Commandes(),
        '4' : (context) => Aide(),
      },
      home: Scaffold(
        body: ProfileScreen() ,
        drawer: Mydrawer() ,
      ),
    );
  }

}