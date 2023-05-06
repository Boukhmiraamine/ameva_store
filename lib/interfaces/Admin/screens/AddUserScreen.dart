
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
  final _nameRegExp = RegExp(r"^[A-Za-z]+(?:[ _-][A-Za-z]+)*$");
  final _emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp phoneRegex = RegExp(r'^[\d\s\+\.-]+$');

  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late String _pw;
  late String _address;
  bool _obscureText=true;
  File? _image;

  Future _getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Add a profile picture'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text('Take a picture'),
                                    onTap: () {
                                      _getImageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    child: Text('Select from gallery'),
                                    onTap: () {
                                      _getImageFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.deepPurpleAccent,
                      child:_image == null
                          ? Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.pink,
                      )
                          : ClipOval(
                        child: Image.file(
                          _image! as File,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your First Name ';
                    } else if (!_nameRegExp.hasMatch(value)) {
                      return 'Invalid first name';
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
                    } else if (!_nameRegExp.hasMatch(value)) {
                      return 'Invalid last name';
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
                    } else if (!_emailRegExp.hasMatch(value)) {
                              return 'Invalid email';}
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
                    } else if (!phoneRegex.hasMatch(value)) {
                      return 'Invalid Phone';
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
                    } else if (!_nameRegExp.hasMatch(value)) {
                      return 'Invalid Adress';
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
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
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
                        Firebase.addUser(newUser, profileImage: _image).then((value) {
                            _auth.createUserWithEmailAndPassword(
                              email: _email,
                                password: _pw,
                             ).then((value) {
                            //Navigator.of(context).pop(true);
                              Navigator.popAndPushNamed(context, '/users');
                        });});
                      }
                    },
                    child: Text('Save'),
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