import 'package:app11/interfaces/Admin/models/usermodel.dart';
import 'package:app11/interfaces/Admin/screens/showEditUserScreen.dart';
import 'package:app11/profile_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:app11/interfaces/Admin/screens/showEditUserScreen.dart';

import 'interfaces/Admin/utils/firebaseUser.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
   late User _currentUser;


  @override
  void initState() {
    super.initState();
    getCurrentUser().then((currentUser) {
      setState(() {
        _currentUser = currentUser!;
      });
    });
  }

    Future<User> getCurrentUser()  async {
    final fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // Récupère l'utilisateur actuellement connecté
    final fb.User? firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      // Récupère les données utilisateur de la collection "users" dans Firestore
      final DocumentSnapshot doc =
      await db.collection('users').doc(firebaseUser?.uid).get();
      final userData = doc.data() as Map<String, dynamic>;

      // Crée un objet User avec les données récupérées de Firestore
      final User currentUser = User.fromMap(userData, firebaseUser.uid);

        _currentUser = currentUser;
      return currentUser;

    } else {
      throw Exception('Aucun utilisateur n\'est connecté.');
    }
  }
   void _showEditUserScreen(User user) async {
     String? ID=user.uid;
     final result = await Navigator.of(context).push(
       MaterialPageRoute(
         builder: (_) => EditUserScreen(user: user),
       ),
     );
     if (result == true) {
       getCurrentUser().then((user) {
         setState(() {
           _currentUser = _currentUser;
         });
       });
     }

   }

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
          IconButton(
          onPressed: () => _showEditUserScreen(_currentUser),
    icon: const Icon(Icons.edit),
    ),

        ],
      ),
    );
  }

}
