import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/usermodel.dart';
import '../utils/constants.dart' as Constants;
import '../utils/firebaseUser.dart';
import 'users.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameRegExp = RegExp(r"^[A-Za-z]+(?:[ _-][A-Za-z]+)*$");
  final _emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp phoneRegex = RegExp(r'^[\d\s\+\.-]+$');
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;
  bool _obscureText = true;
  File? _image;

  @override
  void initState() {
    super.initState();
    _fnameController = TextEditingController(text: widget.user.fname);
    _lnameController = TextEditingController(text: widget.user.lname);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _addressController = TextEditingController(text: widget.user.adresse);
    _passwordController = TextEditingController(text: widget.user.pw);
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
    Color mainColor = Constants.mainColor;
    Color secColor = Colors.deepPurple;
    Color textColor = Constants.textColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit User',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: secColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                    backgroundColor: secColor,
                    child:_image == null
                        ? Icon(
                      Icons.person,
                      size: 70,
                      color: mainColor,
                    )
                        : ClipOval(
                      child: Image.file(
                        _image!,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _fnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  } else if (!_nameRegExp.hasMatch(value)) {
                    return 'Invalid first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _lnameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  } else if (!_nameRegExp.hasMatch(value)) {
                    return 'Invalid last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  } else if (!_emailRegExp.hasMatch(value)) {
                        return 'Invalid email';

                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }   else if (!phoneRegex.hasMatch(value)) {
                    return 'Invalid Phone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: mainColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    User updatedUser = User(
                      uid: widget.user.uid,
                      fname: _fnameController.text,
                      lname: _lnameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      pw: _passwordController.text,
                      adresse: _addressController.text,
                    );
                    final firebaseUser = Firebase();
                    if (_image != null) {
                      String imageUrl = await firebaseUser.uploadImage(_image!, widget.user.uid);
                      updatedUser = updatedUser.copyWith(profileImageUrl: imageUrl);
                    }
                    await firebaseUser.updateUser(updatedUser);
                    Navigator.popAndPushNamed(context, '/users');
                  }
                },
                child: Text('Save'),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
