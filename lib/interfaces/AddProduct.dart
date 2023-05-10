
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  var _productName;
  var _productDescription;
  var _productImageUrl;
  var _productColor;
  var _productCategory;

  File? _imageFile2;

  List<String> _categories = ['Electronics', 'Clothing', 'Home Goods'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundImage:
                _imageFile2 == null
                    ?NetworkImage("https://static.vecteezy.com/system/resources/previews/014/731/219/original/product-owner-line-icon-vector.jpg") as ImageProvider
                    :FileImage(File(_imageFile2!.path)),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    label: Text('Upload Image'),
                    backgroundColor: Colors.deepPurpleAccent,
                    icon: Icon(
                      Icons.save,
                      size: 24.0,
                    ),
                    onPressed: () {
                      _showImagePicker();
                    },
                  ),
                ],
              ),
              SizedBox(height: 80.0),
              TextFormField(
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    labelText: 'Product Name',
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  focusColor: Colors.deepPurple,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
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
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  focusColor: Colors.deepPurple,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
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
                    return 'Please enter a product description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productDescription = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                  labelText: 'Product Color',
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  focusColor: Colors.deepPurple,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
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
                    return 'Please enter a product color';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productColor = value;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Product Category',
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  focusColor: Colors.deepPurple,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.deepPurple
                    ),
                  ),
                ),
                value: _productCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _productCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a product category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  child: Text('Save'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent)
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      _saveProduct();

                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePicker() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile!= null) {
        _imageFile2 = File(pickedFile!.path);
      }
    });
  }

  void _saveProduct() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // L'utilisateur n'est pas connecté, traiter le cas d'erreur
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your product is in the wait list products'),
          ),
      );
      final ref = FirebaseStorage.instance
          .ref()
          .child('products')
          .child(_productName)
          .child('productImage.jpg');
      await ref.putFile(_imageFile2!);

      final url = await ref.getDownloadURL();
      print("----------------*****************************************************");
      print("----------------"+ url);
      FirebaseFirestore.instance.collection('waiting_products').doc().set({
        'name': _productName,
        'description': _productDescription,
        'image': url,
        'color': _productColor,
        'category': _productCategory,
        'publication_date': FieldValue.serverTimestamp(),
        'user_id': user.uid, // Ajouter l'ID de l'utilisateur ici
      }

      );
    } catch (error) {
      print(error);
      // TODO: Show error message to user
    }
  }

}