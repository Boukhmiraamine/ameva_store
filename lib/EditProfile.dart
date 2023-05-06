<<<<<<< HEAD

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserDataForm extends StatefulWidget {
  final String userId;
=======
import 'package:app11/interfaces/Admin/models/usermodel.dart';
import 'package:app11/interfaces/Admin/screens/showEditUserScreen.dart';
import 'package:app11/profile_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:app11/interfaces/Admin/screens/showEditUserScreen.dart';

import 'interfaces/Admin/utils/firebaseUser.dart';
>>>>>>> 3d34d628e75a772b9968de154c555bec5eb68d32

  EditUserDataForm({required this.userId});

  @override
  _EditUserDataFormState createState() => _EditUserDataFormState();
}

<<<<<<< HEAD
class _EditUserDataFormState extends State<EditUserDataForm> {
  final _formKey = GlobalKey<FormState>();
=======
class _EditProfileState extends State<EditProfile> {
   late User _currentUser;
>>>>>>> 3d34d628e75a772b9968de154c555bec5eb68d32

  String _fname = '';
  String _lname = '';
  String _email = '';
  String _phonenumber = '';
  String _adress = '';

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
        title: Text('Personal Informations'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
<<<<<<< HEAD
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var userData = snapshot.data!.data();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    // initialValue: userData!['first name'],
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fname = value!;
                    },
                  ),
                  TextFormField(
                    // initialValue: userData!['first name'],
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lname = value!;
                    },
                  ),
                  TextFormField(
                    // initialValue: userData!['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  TextFormField(
                    // initialValue: userData!['first name'],
                    decoration: InputDecoration(labelText: 'Adress'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Adress';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _adress = value!;
                    },
                  ),
                  TextFormField(
                    // initialValue: userData!['first name'],
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Phone Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phonenumber = value!;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        updateUserData();
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
=======
      body: Column(
        children: [
          IconButton(
          onPressed: () => _showEditUserScreen(_currentUser),
    icon: const Icon(Icons.edit),
    ),

        ],
>>>>>>> 3d34d628e75a772b9968de154c555bec5eb68d32
      ),
    );
  }

<<<<<<< HEAD
  void updateUserData() {
    FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'first name': _fname,
      'last name': _lname,
      'email': _email,
      'adresse': _adress,
      'phone' : _phonenumber
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data updated successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user data')),
      );
    });
  }
=======
>>>>>>> 3d34d628e75a772b9968de154c555bec5eb68d32
}
