import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'EditProfile.dart';


enum SampleItem { itemOne, itemTwo, itemThree }

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (String value) {
        // Handle menu item selection
        if (value == 'Page 1') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserDataForm(userId: FirebaseAuth.instance.currentUser!.uid)));
        } else if (value == 'Page 2') {
          FirebaseAuth.instance.signOut();
        }
      },
      itemBuilder: (BuildContext context) => [
        // Define the menu items
        PopupMenuItem(
          value: 'Page 1',
          child: Text('Edit Profile'),
        ),
        PopupMenuItem(
          value: 'Page 2',
          child: Text('Log Out'),
        ),
      ],
    );
  }
}
