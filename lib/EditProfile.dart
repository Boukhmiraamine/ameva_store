import 'package:app11/interfaces/Admin/models/usermodel.dart';
import 'package:app11/interfaces/Admin/screens/showEditUserScreen.dart';
import 'package:app11/profile_image.dart';
import 'package:flutter/material.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final User user;

  late final String? fname;
  late final String? lname;
  late final String? email;
  late final String? phone;
  late final String? pw;
  late final String? adresse;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ProfileImage(),
          SizedBox(height: 30,),
          EditUserScreen(user:,),
        ],
      ),
    );
  }
}
