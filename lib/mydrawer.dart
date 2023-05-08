import 'package:app11/EditProfile.dart';
import 'package:app11/interfaces/Admin/utils/urllinks.dart';
import 'package:app11/nom.dart';
import 'package:app11/profile_image.dart';
import 'package:app11/telephone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'email&password.dart';
import 'mydrawerheader.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          MyDrawerHeader() ,
          SizedBox(height: 14,),
          ListTile(
            leading: Icon(Icons.edit,color: Colors.deepPurple.shade200),
            title: Text("Edit Profile",style: TextStyle(fontSize: 16,color: Colors.black),),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserDataForm(userId: FirebaseAuth.instance.currentUser!.uid),
                ),
              );
            },
          ),
          // SizedBox(height: 14,),
          // ListTile(
          //   leading: Icon(Icons.edit,color: Colors.deepPurple.shade200),
          //   title: Text("Name",style: TextStyle(fontSize: 16,color: Colors.black),),
          //   trailing: Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Nom(),
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(height: 14,),
          // ListTile(
          //   leading: Icon(Icons.edit,color: Colors.deepPurple.shade200),
          //   title: Text("Phone Number",style: TextStyle(fontSize: 16,color: Colors.black),),
          //   trailing: Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Phone(),
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(height: 14,),
          // ListTile(
          //   leading: Icon(Icons.edit,color: Colors.deepPurple.shade200),
          //   title: Text("Email qnd Password",style: TextStyle(fontSize: 16,color: Colors.black),),
          //   trailing: Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => EmailEtPassword(),
          //       ),
          //     );
          //   },
          // ),
          SizedBox(height: 170,),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.deepPurple.shade200),
            title: Text("Log-out",style: TextStyle(fontSize: 16,color: Colors.black),),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          SizedBox(height: 14,),


          // Mylisttiles(Icons.info,"Nom et Prénom",'1') ,
          // Mylisttiles(Icons.payment,"Numéro de Téléphone",'2'),
          // Mylisttiles(Icons.shopping_cart,"Email et mot de passe",'3'),
          // // Mylisttiles(Icons.help,"Aide",'4'),
        ],
      ),
    );
  }
  // Widget Mylisttiles(ico,text,String val){
  //   return ListTile(
  //     leading: Icon(ico,color: Colors.deepPurple.shade200),
  //     title: Text(text,style: TextStyle(fontSize: 16,color: Colors.black),),
  //     trailing: Icon(Icons.arrow_right),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => EmailEtPassword(),
  //         ),
  //       );
  //     },
  //   );
  // }
}

