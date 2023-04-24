import 'package:app11/FirstInterface.dart';
import 'package:flutter/material.dart';

Widget container(icon,color,title){
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Container(
      color: color,
      //height: 90,
      child: ListTile(
        onTap: () {

        },
        //tileColor: Colors.red,
        title: Text(title),
        leading: Icon(icon),
      ),
    ),
  );
}
class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Products Category"),
          backgroundColor: Colors.deepPurple,

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: container(Icons.phone_android,Colors.lightBlueAccent,"Phones"),
              ),

              container(Icons.local_post_office,Colors.amberAccent,"Bureautique"),
              container(Icons.car_crash,Colors.lightGreen,"Transport"),


            ],
          ),
        ),
      ),
    );
  }
}
