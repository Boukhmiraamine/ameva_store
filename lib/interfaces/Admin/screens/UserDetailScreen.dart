import 'dart:math';

import 'package:flutter/material.dart';
import '../models/usermodel.dart';
import '../utils/constants.dart' as Constants;

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Constants.secTextColor;
    Color textColor = Constants.textColor;
    Color accentColor = Colors.deepPurpleAccent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails de l\'utilisateur',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(user.profileImageUrl!),
              ),*/
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.accents[Random().nextInt(Colors.accents.length)],
                  radius: 50.0,
                  child: Text(
                    _getTitle(user.fname!),
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text("Nom", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Text(
                '${user.fname!} ',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              SizedBox(height: 20.0),
              Text("Prenom", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Text(
                ' ${user.lname!}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              SizedBox(height: 20.0),
              Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Text(
                user.email!,
                style: TextStyle(
                  fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                ),
              ),
              SizedBox(height: 20.0),
              Text("Téléphone", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Text(
                user.phone!,
                style: TextStyle(
                  fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                ),


              ),
              SizedBox(height: 20.0),
              Text("Mote de passe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Text(
                user.pw!,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              SizedBox(height: 20.0),
              Text("Adresse", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Text(
                user.address!,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],


        ),]
      ),
    );
  }
  String _getTitle(String first_name) {
    return first_name.substring(0, 1);
  }
}
