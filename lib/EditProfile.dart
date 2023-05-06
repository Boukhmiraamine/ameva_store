
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserDataForm extends StatefulWidget {
  final String userId;

  EditUserDataForm({required this.userId});

  @override
  _EditUserDataFormState createState() => _EditUserDataFormState();
}

class _EditUserDataFormState extends State<EditUserDataForm> {
  final _formKey = GlobalKey<FormState>();

  String _fname = '';
  String _lname = '';
  String _email = '';
  String _phonenumber = '';
  String _adress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Informations'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
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
      ),
    );
  }

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
}
