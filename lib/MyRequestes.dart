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
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text((exchangeData
                    as Map<String, dynamic>)['proposerProductName']),
                subtitle:
                    Text((exchangeData as Map<String, dynamic>)['description']),
                trailing: Text("re"),
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
              ),
            );
          },
        );
      },
    );
  }
}
