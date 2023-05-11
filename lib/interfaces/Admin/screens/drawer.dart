
import 'package:firebase_auth/firebase_auth.dart';

import 'users.dart';

import 'package:flutter/material.dart';
import '../utils/constants.dart' as Constants;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {


  var value;
  String? user;
  String? username;


  @override
  void initState() {
    readCreds().then((data){
      setState(() {
      });
    });
    super.initState();
  }

  Future<dynamic> readCreds() async {
    //value = await loginState.storage.readAll();
    user = await value["token2"];
    username = await value["token1"];
    return [user, username];
  }

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _drawerHeader(),
          _dashboard(context),
          _products(),
          _WaitingProduct(),
          _users(),
          _logout(context),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    var app = DrawerHeader(
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 100,
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child: Image.asset('assets/images/admin.png', width: 100.0, height: 80.0),
            ),
            Text(
              (user == null)? 'Admin': user!,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white),
            ),
            Text(
              (username == null)? 'Admin': 'Username: '+username!,
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
            // Text(
            //   'Admin',
            //   style: TextStyle(
            //     color: mainColor,
            //     fontSize: 10.0
            //     ),
            //   )
          ],
        ),
      ),
    );
    return app;
  }

  Widget _dashboard(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.home, color: Colors.deepPurple.shade200),
      title: Text('Dashboard'),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.popAndPushNamed(context, '/home');
      },
    );

    return app;
  }

  Widget _logout(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.logout,color: Colors.deepPurple.shade200),
      title: Text('Log Out'),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        FirebaseAuth.instance.signOut();
        Navigator.popAndPushNamed(context, '/logout');
      },
    );

    return app;
  }

  Widget _WaitingProduct() {
    var app = ListTile(
      leading: Icon(Icons.shop,color: Colors.deepPurple.shade200),
      title: Text('Waiting Products'),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        //Navigator.popAndPushNamed(context, '/category');
        Navigator.popAndPushNamed(context, '/waitingproduct');
      },
    );
    return app;
  }

  Widget _users() {
    var app = ListTile(
      leading: Icon(Icons.people,color: Colors.deepPurple.shade200),
      title: Text('Users'),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.popAndPushNamed(context, '/users');
      },
    );
    return app;
  }

  Widget _products() {
    var app = ListTile(
      leading: Icon(Icons.devices_other,color: Colors.deepPurple.shade200),
      title: Text('Products'),
      trailing: Icon(Icons.arrow_right),
      onTap: ()
      {
        Navigator.popAndPushNamed(context, '/approved');
      },
    );
    return app;
  }
}
