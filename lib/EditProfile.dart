import 'package:app11/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  String _adress = '';
  String _phone = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Data'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          ProfileImage(),
          SizedBox(height: 15,),
          StreamBuilder<DocumentSnapshot>(
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
                        // initialValue: userData!['First name'],
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                            labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          focusColor: Colors.deepPurple,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple), // Border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepPurple
                            ),
                          ),

                        ),
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
                      SizedBox(height: 10,),
                      TextFormField(
                        // initialValue: userData!['Last name'],
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          focusColor: Colors.deepPurple,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple), // Border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepPurple
                            ),
                          ),

                        ),
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
                      SizedBox(height: 10,),
                      TextFormField(
                        // initialValue: userData!['Last name'],
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          focusColor: Colors.deepPurple,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple), // Border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepPurple
                            ),
                          ),
                          hintText: "",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phone = value!;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        // initialValue: userData!['email'],
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          focusColor: Colors.deepPurple,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple), // Border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepPurple
                            ),
                          ),
                          hintText: "xyz@gmail.com",
                        ),
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
                      SizedBox(height: 10,),
                      TextFormField(
                        // initialValue: userData!['email'],
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                            labelText: 'Adress',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          focusColor: Colors.deepPurple,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple), // Border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepPurple
                            ),
                          ),
                          hintText: "Robert Robertson, 1234 NW Bobcat Lane",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an adress';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _adress = value!;
                        },
                      ),
                      SizedBox(height: 10,),
                      // InternationalPhoneNumberInput(
                      //   onSaved: (value) {
                      //     _phone = value! as String;
                      //   },
                      //   cursorColor: Colors.deepPurple,
                      //   formatInput: false,
                      //   selectorConfig: SelectorConfig(
                      //       selectorType: PhoneInputSelectorType.DIALOG
                      //   ),
                      //   inputDecoration: InputDecoration(
                      //       hintText: "Phone number",
                      //       hintStyle: TextStyle(
                      //         color: Colors.grey.shade500,
                      //         fontSize: 17,
                      //       ),
                      //     focusColor: Colors.deepPurple,
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.deepPurple), // Border color when focused
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //           width: 2,
                      //           color: Colors.deepPurple
                      //       ),
                      //     ),
                      //   ),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter a phone number';
                      //     }
                      //     return null;
                      //   }, onInputChanged: (PhoneNumber value) {  },
                      //   // onSaved: (value) {
                      //   //   _phone = value! as String;
                      //   // },
                      // ),
                      SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              updateUserData();
                            }
                          },
                          child: Text('Save'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void updateUserData() {
    FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'first name': _fname,
      'last name': _lname,
      'adresse': _adress,
      'phone': _phone,
      'email': _email,
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