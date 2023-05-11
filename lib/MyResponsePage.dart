import 'package:app11/DetailTargetUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyResponsePage extends StatefulWidget {
  @override
  _MyResponsePagePageState createState() => _MyResponsePagePageState();
}

class _MyResponsePagePageState extends State<MyResponsePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('exchanges')
          .where('proposerUserId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final exchangeDocs = snapshot.data!.docs;

        if (exchangeDocs.isEmpty) {
          return Center(
            child: Column(
              children: [
                Text('You don\'t have any response'),
                Icon(Icons.error_outline,size: 20,color: Colors.deepPurple,)
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: exchangeDocs.length,
          itemBuilder: (context, index) {
            final exchangeDoc = exchangeDocs[index];
            final exchangeData = exchangeDoc.data();

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey[300],
              child: ListTile(
                leading: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('products')
                      .doc((exchangeData
                          as Map<String, dynamic>)['proposerProductId'])
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      var productData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      var productImage = productData['image'];

                      return CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(productImage),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 50,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                title: Text(
                  (exchangeData as Map<String, dynamic>)['targetUserName'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold, // ajout du style du texte en gras
                  ),
                ),
                subtitle: Text(
                  (exchangeData as Map<String, dynamic>)['proposerProductName'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                trailing:
                    Text((exchangeData as Map<String, dynamic>)['reponse']),
                onTap: () {

                  if((exchangeData as Map<String, dynamic>)['reponse'] == 'I refuse the exchange'){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(children: [Text('The Target user has refused the exchange',style: TextStyle(color: Colors.red),),
                        Icon(Icons.dangerous_outlined)
                        ]),
                      ),
                    );
                  }else if ((exchangeData as Map<String, dynamic>)['reponse'] == 'I accept the exchange'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailTargetUser(exchangeId: exchangeDoc.id)),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:  Text('In process .....',style: TextStyle(color: Colors.blue),),
                    ));
                  }



                },
                selected: true, // Whether the ListTile is selected or not
                enabled: true, // Whether the ListTile is enabled or not
                dense: false, // Whether the ListTile has reduced height or not
                selectedTileColor: Colors.deepPurple[
                    50], // ajout de la couleur de sélection pour le ListTile
                shape: RoundedRectangleBorder(
                    // ajout d'une bordure pour le ListTile

                    ),
                tileColor: Colors
                    .white, // ajout de la couleur d'arrière-plan pour le ListTile
                horizontalTitleGap:
                    10.0, // ajout de l'espace horizontal entre le leading et le title
              ),
            );
          },
        );
      },
    );
  }
}
