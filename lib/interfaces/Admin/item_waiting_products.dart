import 'package:app11/Modules/Product.dart';
import 'package:app11/interfaces/Admin/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



Widget item_waiting_products(Product product, BuildContext context) {
  return Card(
    color: Colors.grey[300],
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 2,
        color: Colors.deepPurple.shade300,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 500,
      width: 500,
      child: Column(
        children: [
          ListTile(
            title: Text(product.name, style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category: #${product.category}",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black54,fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black45),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(
                        product.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                      onPressed: () async {
                        _saveProduct(product);



                        await FirebaseFirestore.instance
                            .collection('waiting_products')
                            .doc(product.id)
                            .delete();
                        print('Product deleted');




                      },
                      child: Text("Accept"),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmation"),
                              content: Text("Are you sure you want to refuse this product ?"),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Refuse",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('waiting_products')
                                          .doc(product.id)
                                          .delete();
                                      print('Product deleted');
                                    } catch (error) {
                                      print('Error deleting product: $error');
                                    }
                                    //Navigator.of(context).pop();
                                    Navigator.popAndPushNamed(context, '/waiting_products');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Refuse"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void _saveProduct(Product product) async {
  // Get a reference to the Firestore collection
  final productCollection = FirebaseFirestore.instance.collection('products');
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // L'utilisateur n'est pas connecté, traiter le cas d'erreur
    return;
  }
  try {
    // Create a new document and set its fields
    await productCollection.add({
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'image': product.image,
      'color': product.image,
      'category': product.category,
      'publication_date': product.publication_date,
      'user_id': user.uid, // Ajouter l'ID de l'utilisateur ici
    });
    print('Product saved successfully!');
  } catch (e) {
    print('Error saving product: $e');
  }
}

