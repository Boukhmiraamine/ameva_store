import 'dart:math';
import 'package:app11/interfaces/Admin/screens/showEditUserScreen.dart';
import '../models/usermodel.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart' as Constants;
import '../utils/firebaseUser.dart';
import 'AddUserScreen.dart';
import 'UserDetailScreen.dart';
import 'drawer.dart';

class UserScreen extends StatefulWidget {

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {

  late List<User> _users;
  List<User> _filteredUsers = [];
  Widget get _listUser => getUserList();
  bool _showSearchBar = false;
  String searchTerm='';

  TextEditingController searchTermController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _users = [];
    Firebase.getUsers().then((users) {
      setState(() {
        _users=users;
        _filteredUsers=_users;
      });
    });
    super.initState();
  }

  void _showEditUserScreen(User user) async {
    String? ID=user.uid;
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditUserScreen(user: user),
      ),
    );
    if (result == true) {
      Firebase.getUsers().then((user) {
        setState(() {
          _users = _users;
        });
      });
    }
  }
  void _showAddUserScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddUserScreen()),
    );
    if (result == true) {
      Firebase.getUsers().then((users) {
        setState(() {
          _users = users;
        });
      });
    }
  }

  void _searchUsers(value)  {

      setState(() {
        searchTerm=value;
        _filteredUsers = _users.where((user) =>
        user.fname!.toLowerCase().contains(searchTerm.toLowerCase()) ||
            user.lname!.toLowerCase().contains(searchTerm.toLowerCase()))
            .toList();
      });

  }


  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Colors.deepPurple;
    Color textColor = Constants.textColor;

    var app = Scaffold(

      appBar: AppBar(
        title: !_showSearchBar?
        Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ):
            TextField(

                autofocus: true,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  //hoverColor: Colors.green,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,

                  hintText: "Search User ...",

                ),
                onChanged: _searchUsers
            ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: secColor,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: getUserList(),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserScreen,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
    return app;
  }

  Widget getUserList() {
    final users = _filteredUsers.isNotEmpty ? _filteredUsers : _users;
    return ListView.builder(
        itemCount: _filteredUsers.length,
        itemBuilder: (BuildContext context, int index) {
          User userModel = _filteredUsers[index];
          String fullName = userModel.fname! + ' ' + userModel.lname!;
          String role = "User";
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.accents[Random().nextInt(Colors.accents.length)],
              radius: 22.0,
              child: Text(
                _getTitle(userModel.fname!),
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(fullName),
            subtitle: Text(role),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetailScreen(user: userModel)),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showEditUserScreen(userModel),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmation"),
                          content: Text("Are you sure you want to delete this user ?"),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Firebase.deleteUser(userModel.uid);
                                //Navigator.of(context).pop();
                                Navigator.popAndPushNamed(context, '/users');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),

          );
        },
    );

  }
  String _getTitle(String first_name) {
    return first_name.substring(0, 1);
  }
}
