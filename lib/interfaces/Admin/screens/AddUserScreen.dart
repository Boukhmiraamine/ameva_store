import '../utils/firebaseUser.dart';
import 'package:flutter/material.dart';
import '../models/usermodel.dart' as usermodel;
import 'package:firebase_auth/firebase_auth.dart';
final _auth = FirebaseAuth.instance;
class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late String _pw;
  late String _address;
  bool _obscureText=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your First Name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Last Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Phone';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value!;
                  },
                ),
                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'PassWord',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 10.0),
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                    suffixIcon: GestureDetector(onTap: (){
                      setState(()
                      {
                        _obscureText=! _obscureText;
                      });

                    }, child: Icon(_obscureText? Icons.visibility: Icons.visibility_off, color: Colors.deepPurple,),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your PassWord';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _pw = value!;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        usermodel.User newUser = usermodel.User(
                          uid: '',
                          fname: _firstName,
                          lname: _lastName,
                          email: _email,
                          phone: _phone,
                          pw: _pw,
                          adresse: _address,
                          profileImageUrl: '',
                        );
                        Firebase.addUser(newUser).then((value) {
                            _auth.createUserWithEmailAndPassword(
                              email: _email,
                                password: _pw,
                             ).then((value) {
                            //Navigator.of(context).pop(true);
                              Navigator.popAndPushNamed(context, '/users');
                        });});
                      }
                    },
                    child: Text('Enregistrer'),
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}