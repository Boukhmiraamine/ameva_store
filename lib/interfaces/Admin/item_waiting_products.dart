import 'package:app11/Modules/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget item_waiting_products(Product product) {
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
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.description),
                Text(product.category),
                ElevatedButton(
                  onPressed: () async {
                    _saveProduct(product);



                        await FirebaseFirestore.instance
                            .collection('waiting_products')
                            .doc(product.id)
                            .delete();
                        print('Product deleted');
                   



                  },
                  child: Text("Accept product"),
                ),
                ElevatedButton(


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
                  },
                  child: Text("refuse"),
                )
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

  try {
    // Create a new document and set its fields
    await productCollection.add({
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'imageUrl': product.image,
      'color': product.image,
      'category': product.category,
      'publication_date': product.publication_date,
    });
    print('Product saved successfully!');
  } catch (e) {
    print('Error saving product: $e');
  }
}

