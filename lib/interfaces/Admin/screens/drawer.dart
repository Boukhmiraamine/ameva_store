
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
        children: <Widget>[
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
      decoration: BoxDecoration(
        color: secColor,
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Image.asset('images/admin.png', width: 80.0, height: 80.0),
              ),
            ),
            Text(
              (user == null)? 'Admin': user!,
              style: TextStyle(
                  color: textColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              (username == null)? 'Admin': 'Username: '+username!,
              style: TextStyle(color: mainColor, fontSize: 10.0),
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
      leading: Icon(Icons.home),
      title: Text('Dashboard'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/home');
      },
    );

    return app;
  }

  Widget _logout(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.logout),
      title: Text('Log Out'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/logout');
      },
    );

    return app;
  }

  Widget _WaitingProduct() {
    var app = ListTile(
      leading: Icon(Icons.shop),
      title: Text('Waiting Products'),
      onTap: () {
        //Navigator.popAndPushNamed(context, '/category');
        Navigator.popAndPushNamed(context, '/waitingproduct');
      },
    );
    return app;
  }

  Widget _users() {
    var app = ListTile(
      leading: Icon(Icons.people),
      title: Text('Users'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/users');
      },
    );
    return app;
  }

  Widget _products() {
    var app = ListTile(
      leading: Icon(Icons.devices_other),
      title: Text('Products'),
      onTap: ()
      {
        Navigator.popAndPushNamed(context, '/approved');
      },
    );
    return app;
  }
}
