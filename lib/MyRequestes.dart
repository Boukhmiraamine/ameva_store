import 'package:app11/ConfermationPage.dart';
import 'package:app11/MyResponsePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRequestes extends StatefulWidget {
  @override
  _MyRequestesState createState() => _MyRequestesState();
}

class _MyRequestesState extends State<MyRequestes> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MyRequestsPage(),
    MyResponsePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Requests & Responses"),
        backgroundColor: Colors.deepPurple,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.insert_invitation),
            label: 'My Requests',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.question_answer_outlined),
            label: 'My Responses',
          )
        ],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 16.0),
        unselectedLabelStyle: TextStyle(fontSize: 14.0),
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class MyRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('exchanges')
          .where('targetUserId',
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
                Text('You don\'t have any Request'),
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
              color: Colors.grey[300], // ajout de la couleur de fond grise
              child: ListTile(
/*
                leading: Icon(Icons.person),
                title: Text((exchangeData
                    as Map<String, dynamic>)['proposerProductName']),
                subtitle:
                    Text((exchangeData as Map<String, dynamic>)['description']),
                trailing: Text("er"),
*/
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // ajout du padding du contenu
                leading: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('products').doc((exchangeData as Map<String, dynamic>)['proposerProductId']).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      var productData = snapshot.data!.data() as Map<String, dynamic>;
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
                  (exchangeData as Map<String, dynamic>)['proposerProductName'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // ajout du style du texte en gras
                  ),
                ),
                subtitle: Text(
                  (exchangeData as Map<String, dynamic>)['description'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  color: Colors.deepPurple,
                  onPressed: () {
                    // Ajoutez ici le code à exécuter lorsqu'on appuie sur l'icône "info"
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ConfermationPage(exchangeId: exchangeDoc.id)),
                    );
                  },
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ConfermationPage(exchangeId: exchangeDoc.id)),
                  );
                },
                selected: true, // Whether the ListTile is selected or not
                enabled: true, // Whether the ListTile is enabled or not
                dense: false, // Whether the ListTile has reduced height or not
                selectedTileColor: Colors.deepPurple[50], // ajout de la couleur de sélection pour le ListTile
                shape: RoundedRectangleBorder( // ajout d'une bordure pour le ListTile

                ),
                tileColor: Colors.white, // ajout de la couleur d'arrière-plan pour le ListTile
                horizontalTitleGap: 10.0, // ajout de l'espace horizontal entre le leading et le title
              ),
            );

          },
        );
      },
    );
  }
}
