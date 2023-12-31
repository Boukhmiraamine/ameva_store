import 'package:app11/Modules/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendRequestPage extends StatefulWidget {
  final Product product;
  final Product targetProduct;

  const SendRequestPage(
      {Key? key, required this.product, required this.targetProduct})
      : super(key: key);
  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _descriptionController =
      TextEditingController(text: "I want to exchange ");

  void _sendRequest() async {
    final newDocRef = _firestore.collection('exchanges').doc();
    final newDocId = newDocRef.id;

    // Récupérer le document utilisateur correspondant à l'ID de l'utilisateur actuel
    final userDoc = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final proposerUserName = userDoc.get('first name');

    // Récupérer le document produit correspondant à l'ID du produit ciblé
    final targetProductDoc = await _firestore
        .collection('products')
        .doc(widget.targetProduct.id)
        .get();
    final targetUserId = targetProductDoc.get('user_id');

    // Récupérer le document utilisateur correspondant à l'ID de l'utilisateur ciblé
    final targetUserDoc =
        await _firestore.collection('users').doc(targetUserId).get();
    final targetUserName = targetUserDoc.get('first name');
    // Récupérer le document utilisateur correspondant à l'ID de l'utilisateur ciblé
    final PropIdDac =
        await _firestore.collection('users').doc(targetUserId).get();
    final PropId = PropIdDac.get('phone');
    await newDocRef.set({
      'createdOn': DateTime.now().toString(),
      'id': newDocId,
      'proposerProductId': widget.product.id,
      'proposerProductName': widget.product.name,
      'proposerUserId': FirebaseAuth.instance.currentUser!.uid,
      'proposerUserName':
          proposerUserName, // Utiliser le nom d'utilisateur récupéré
      'reponse': 'in process',
      'targetProductId': widget.targetProduct.id,
      'targetProductName': widget.targetProduct.name,
      'targetUserId': targetUserId,
      'targetUserName':
          targetUserName, // Utiliser le nom d'utilisateur ciblé récupéré
      'description': _descriptionController.text,
      'phoneprop': PropId,
    });

    // Afficher un snackbar pour indiquer que la demande a été envoyée
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Request sent!'),
    ));

    // Revenir à l'écran précédent
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.product.name),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Message :',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.8, 0, 0.8, 0.8),
                    child: SizedBox(

                      child: ElevatedButton(
                        style :ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade300),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(180, 40), // set width and height here
                      ),
                    ),
                        onPressed: _sendRequest,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.send),
                            ),
                            Text("Send Request", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
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
