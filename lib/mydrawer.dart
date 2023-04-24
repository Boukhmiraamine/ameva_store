import 'package:flutter/material.dart';
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
          Mylisttiles(Icons.info,"Informations personneles",'1') ,
          SizedBox(height: 5,),
          Mylisttiles(Icons.payment,"Informations Banquaire",'2'),
          SizedBox(height: 5,),
          Mylisttiles(Icons.shopping_cart,"Mes commandes",'3'),
          SizedBox(height: 5,),
          Mylisttiles(Icons.help,"Aide",'4'),
        ],
      ),
    );
  }
  Widget Mylisttiles(ico,text,String val){
    return ListTile(
      leading: Icon(ico,color: Colors.deepPurple.shade200),
      title: Text(text,style: TextStyle(fontSize: 16,color: Colors.black),),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.of(context).pushNamed(val) ;
      },
    );
  }
}

