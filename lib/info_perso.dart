import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app11/email&password.dart';
import 'package:app11/mydrawer.dart';
import 'package:app11/nom.dart';
import 'package:app11/profile_image.dart';
import 'package:app11/telephone.dart';

class InfoPerso extends StatefulWidget {
  const InfoPerso({Key? key}) : super(key: key);

  @override
  State<InfoPerso> createState() => InfoPersoState();
}

class InfoPersoState extends State<InfoPerso> {
  // File? imageFile ;
  // final ImagePicker _picker = ImagePicker() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informations Personelles"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Mydrawer() ,
      body: Column(
          children: <Widget>[
            //profileimage(),
            ProfileImage(),
            SizedBox(height: 30.0,),
            listeofpersonalinfo(),
          ],
        ),
    );
  }
  // Widget profileimage() {
  //   return Padding(
  //     padding: const EdgeInsets.all(30.0),
  //     child: Center(
  //       child: Stack(
  //         children: [
  //           CircleAvatar(
  //             radius: 70.0,
  //             backgroundImage:
  //             imageFile == null
  //                 ?AssetImage("images/avatar.png") as ImageProvider
  //                 :FileImage(File(imageFile!.path)),
  //           ),
  //           Positioned(
  //             right: 2.0,
  //             bottom: -5.0,
  //             child: Container(
  //               padding: EdgeInsets.all(5.0),
  //               margin: EdgeInsets.symmetric(horizontal: 0.0,vertical: 5.0),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20),
  //                 color: Colors.cyanAccent,
  //               ),
  //               child: InkWell(
  //                 onTap: (){
  //                   showModalBottomSheet(
  //                     context: context,
  //                     builder: ((builder) => bottomsheet()),
  //                   );
  //                 },
  //                 child: Icon(
  //                   Icons.camera_alt,
  //                   color: Colors.lightBlue,
  //                   size: 20,
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   ) ;
  // }
  // Widget bottomsheet(){
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
  //     child: Column(
  //       children: [
  //         Text(
  //           "Choisis une photo de profile",
  //           style: TextStyle(fontSize: 20.0),
  //         ),
  //         SizedBox(height: 20.0,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             TextButton(
  //               onPressed: (){
  //                 takePhoto(ImageSource.camera);
  //               },
  //               child: Column(
  //                 children: [
  //                   Icon(Icons.camera),
  //                   Text("Camera")
  //                 ],
  //               )
  //             ),
  //             TextButton(
  //                 onPressed: (){
  //                   takePhoto(ImageSource.gallery);
  //                 },
  //                 child: Column(
  //                   children: [
  //                     Icon(Icons.photo),
  //                     Text("Gallery")
  //                   ],
  //                 )
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   ) ;
  // }
  Widget listeofpersonalinfo(){
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            title: Text('Nom et Prénom',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
            trailing: Icon(Icons.keyboard_arrow_right_sharp,size: 30,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Nom(),
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text('Numéro de Téléphone',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
            trailing: Icon(Icons.keyboard_arrow_right_sharp,size: 30,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Phone(),
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          // Divider(color: Colors.black,thickness: 1.0,),
          ListTile(
            title: Text('Email et mot de passe',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
            trailing: Icon(Icons.keyboard_arrow_right_sharp,size: 30,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailEtPassword(),
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text('Se déconnecter',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),

            onTap: () {

                FirebaseAuth.instance.signOut();

            },
          ),

        ],
      ),
    );
  }
  // void takePhoto(ImageSource source) async{
  //   final pickedFile = await _picker.pickImage(source: source);
  //   setState(() {
  //     imageFile= File(pickedFile!.path) ;
  //   });
  // }
}
