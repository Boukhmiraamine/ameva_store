import 'dart:math';

import '../models/usermodel.dart';
import '../services/userrepo.dart';
import 'package:flutter/material.dart';
import '../utilis/constants.dart' as Constants;
import 'drawer.dart';

class User extends StatefulWidget {
  User({Key? key}) : super(key: key);

  @override
  UserState createState() => UserState();
}

class UserState extends State<User> {

  List<UserModel> userModels = <UserModel>[
    UserModel(first_name: "Harry", last_name: "Potter", role_id: 2),
    UserModel(first_name: "Hermione", last_name: "Granger", role_id: 3),
    UserModel(first_name: "Ron", last_name: "Weasley", role_id: 4),
    UserModel(first_name: "Naruto", last_name: "Uzumaki", role_id: 5),
    UserModel(first_name: "Sasuke", last_name: "Uchiha", role_id: 6),
    UserModel(first_name: "Itachi", last_name: "Uchiha", role_id: 7),
    UserModel(first_name: "Kakashi", last_name: "Hatake", role_id: 8),
    UserModel(first_name: "Usui", last_name: "Uchiha", role_id: 9),
    UserModel(first_name: "Shikamaru", last_name: "Nara", role_id: 10),
    UserModel(first_name: "Limule", last_name: "Tempest", role_id: 11),
    UserModel(first_name: "Veldra", last_name: "Tempest", role_id: 12),
    UserModel(first_name: "Natsu", last_name: "Dragnir", role_id: 13),
    UserModel(first_name: "Grey", last_name: "Fulbuster", role_id: 14),
    UserModel(first_name: "Lucy", last_name: "Heartfilia", role_id: 15),
    UserModel(first_name: "Mirajane", last_name: "Strauss", role_id: 16),
    UserModel(first_name: "Lissana", last_name: "Strauss", role_id: 17),
    UserModel(first_name: "Elfman", last_name: "Strauss", role_id: 18),
    UserModel(first_name: "Macarof", last_name: "Drear", role_id: 19),
    UserModel(first_name: "Luxux", last_name: "Drear", role_id: 20),
    UserModel(first_name: "Mavis", last_name: "Vermillion", role_id: 21),
    UserModel(first_name: "Zeleph", last_name: "Dragnir", role_id: 22),
    UserModel(first_name: "Erza", last_name: "Scarlet", role_id: 23),
    UserModel(first_name: "Wendy", last_name: "Marvel", role_id: 24),
    UserModel(first_name: "Seijuro", last_name: "Akashi", role_id: 25),
    UserModel(first_name: "Tetsuya", last_name: "Kuroko", role_id: 26),
    UserModel(first_name: "Daiki", last_name: "Aomine", role_id: 27),
    UserModel(first_name: "Ryota", last_name: "Kise", role_id: 28),
    UserModel(first_name: "Atsushi", last_name: "Murasakibara", role_id: 29),
    UserModel(first_name: "Shintaro", last_name: "Midorima", role_id: 30),
  ];

  @override
  void initState() {
    userGet().then((data) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> userGet() async {
    userModels = (await(List<UserModel>)) as List<UserModel>; UserService().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Constants.secTextColor;
    Color textColor = Constants.textColor;

    var app = Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Utilisateurs',
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: secColor,
      ),
      drawer: MyDrawer(),
      body: getUserList(),
    );
    return app;
  }

  ListView getUserList() {
    var app = ListView.builder(
        itemCount: userModels.length == null ? 0 : userModels.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel userModel = userModels[index];
          String fullName = userModel.first_name! + ' ' + userModel.last_name!;
          String role;
          if (userModel.role_id == 1) {
            role = "Admin";
          } else {
            role = "User";
          }
          return ListTile(
            leading: CircleAvatar(
                backgroundColor:
                    Colors.accents[Random().nextInt(Colors.accents.length)],
                radius: 22.0,
                // child: Icon(Icons.person)
                child: Text(_getTitle(userModel.first_name!),style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),),),
            title: Text(fullName),
            subtitle: Text(role),
          );
          // return Card(
          //   margin: EdgeInsets.all(10.0),
          //   child: ListTile(
          //     leading: CircleAvatar(
          //         backgroundColor: Colors.accents[Random().nextInt(Colors.accents.length)] ,
          //         radius: 50.0,
          //         // child: Icon(Icons.person)
          //         child: Text(getTitle(userModel.first_name))),
          //     title: Text(fullName),
          //     subtitle: Text(role),
          //   ),
          // );
        });
    return app;
  }

  String _getTitle(String first_name) {
    return first_name.substring(0, 1);
  }
}
