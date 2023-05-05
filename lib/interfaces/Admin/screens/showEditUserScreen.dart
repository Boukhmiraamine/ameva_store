import 'package:flutter/material.dart';
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
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;
  bool _obscureText=true;


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
    TextFormField(
    controller: _fnameController,
    decoration: InputDecoration(
    labelText: 'First Name',
    border: OutlineInputBorder(),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please entrer your First Name';
    }
    return null;
    },
    ),
    SizedBox(height: 10.0),
    TextFormField(
    controller: _lnameController,
    decoration: InputDecoration(
    labelText: 'Last Name',
    border: OutlineInputBorder(),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please entrer your Last Name';
    }
    return null;
    },
    ),
    SizedBox(height: 10.0),
    TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please entrer your email';
    }
    return null;
    },
    ),
    SizedBox(height: 10.0),
    TextFormField(
    controller: _phoneController,
    decoration: InputDecoration(
    labelText: 'Phone',
    border: OutlineInputBorder(),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please entrer your Phone';
    }
    return null;
    },
    ),
      SizedBox(height: 10.0),
      TextFormField(
        controller: _addressController,
        decoration: InputDecoration(
          labelText: 'Address',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please entrer your Address';
          }
          return null;
        },
      ),
    SizedBox(height: 10.0),
    TextFormField(
    controller: _passwordController,
      obscureText: _obscureText,
    decoration: InputDecoration(
    labelText: 'PassWord',
    border: OutlineInputBorder(),
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

      }, child: Icon(_obscureText? Icons.visibility: Icons.visibility_off),
      ),
    ),
    validator: (value) {
    if (value != null && value.isNotEmpty && value.length < 6) {
    return 'Le mot de passe doit avoir au moins 6 caractères';
    }
    return null;
    },

    ),
      SizedBox(height: 20.0),
      ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
// Update user data in Firestore
            User updatedUser = User(
              uid: widget.user.uid,
              fname: _fnameController.text,
              lname: _lnameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              pw: _passwordController.text,
              adresse: _addressController.text,
              profileImageUrl: '',
            );
            await Firebase.editUser(updatedUser);

// Update password in Firebase Authentication
            /*if (_passwordController.text.isNotEmpty) {
              await Firebase.updatePassword(_passwordController.text);
            }*/

            //Navigator.pop(context, true); // return true to previous screen to indicate user was edited successfully
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