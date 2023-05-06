// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:app11/email&password.dart';
// import 'package:app11/mydrawer.dart';
// import 'package:app11/nom.dart';
// import 'package:app11/profile_image.dart';
// import 'package:app11/telephone.dart';
//
// class InfoPerso extends StatefulWidget {
//   const InfoPerso({Key? key}) : super(key: key);
//
//   @override
//   State<InfoPerso> createState() => InfoPersoState();
// }
//
// class InfoPersoState extends State<InfoPerso> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Informations Personelles"),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Column(
//           children: <Widget>[
//             //profileimage(),
//             ProfileImage(),
//             SizedBox(height: 30.0,),
//             listeofpersonalinfo(),
//           ],
//         ),
//       // drawer: Mydrawer(),
//     );
//   }
//   Widget listeofpersonalinfo(){
//     return Expanded(
//       child: ListView(
//         children: [
//           ListTile(
//             title: Text('Nom et Prénom',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
//             trailing: Icon(Icons.keyboard_arrow_right_sharp,size: 30,),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Nom(),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 10,),
//           ListTile(
//             title: Text('Numéro de Téléphone',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
//             trailing: Icon(Icons.keyboard_arrow_right_sharp,size: 30,),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Phone(),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 10,),
//           // Divider(color: Colors.black,thickness: 1.0,),
//           ListTile(
//             title: Text('Email et mot de passe',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
//             trailing: Icon(Icons.keyboard_arrow_right_sharp,size: 30,),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EmailEtPassword(),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 10,),
//           ListTile(
//             title: Text('Se déconnecter',style: GoogleFonts.questrial(fontWeight: FontWeight.bold,fontSize: 20),),
//
//             onTap: () {
//
//                 FirebaseAuth.instance.signOut();
//
//             },
//           ),
//
//         ],
//       ),
//     );
//   }
//   // void takePhoto(ImageSource source) async{
//   //   final pickedFile = await _picker.pickImage(source: source);
//   //   setState(() {
//   //     imageFile= File(pickedFile!.path) ;
//   //   });
//   // }
// }
