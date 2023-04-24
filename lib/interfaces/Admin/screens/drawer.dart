
import 'users.dart';
import '../services/authrepo.dart';
import 'package:flutter/material.dart';
import '../utilis/constants.dart' as Constants;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  //LoginState loginState = LoginState();
  AuthServices authServices= AuthServices();
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
          _categories(context),
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
      title: Text('Deconnexion'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/logout');
      },
    );

    return app;
  }

  Widget _categories(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.category),
      title: Text('Categoris'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/category');
      },
    );
    return app;
  }

  Widget _users() {
    var app = ListTile(
      leading: Icon(Icons.people),
      title: Text('Utilisateurs'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/users');
      },
    );
    return app;
  }

  Widget _products() {
    var app = ListTile(
      leading: Icon(Icons.devices_other),
      title: Text('Produits'),
      onTap: ()
      {
        Navigator.popAndPushNamed(context, '/approved');
      },
    );
    return app;
  }
}
