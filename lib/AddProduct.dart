
import 'dart:io';
// <<<<<<< HEAD
// =======

import 'package:firebase_auth/firebase_auth.dart';
// >>>>>>> 27f8555f145982eac650bcf40adf97d94ad51d34
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
  File? _imageFile;

  List<String> _categories = ['Electronics', 'Clothing', 'Home Goods'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Upload Image'),
                onPressed: () {
                  _showImagePicker();
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
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
                decoration: InputDecoration(labelText: 'Product Description'),
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
                decoration: InputDecoration(labelText: 'Product Color'),
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
                decoration: InputDecoration(labelText: 'Product Category'),
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
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    _saveProduct();

                    Navigator.pop(context);
                  }
                },
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
        _imageFile = File(pickedFile!.path);
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
      await ref.putFile(_imageFile!);

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