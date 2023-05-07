import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:app11/mydrawerheader.dart';





class ProfileImage extends StatefulWidget {
  ProfileImage({Key? key}) : super(key: key);


  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _imageFile ;
  final ImagePicker _picker = ImagePicker() ;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future uploadImage() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String uid = user!.uid;

    final Reference storageRef =
    FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

    UploadTask uploadTask = storageRef.putFile(_imageFile!);
    TaskSnapshot snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the download URL to the user's profile or database
      // (e.g., Firestore, Realtime Database)
      await _firestore.collection('users').doc(uid).set({
        'profileImageUrl': downloadUrl,
      }, SetOptions(merge: true));


      print('Image uploaded successfully. Download URL: $downloadUrl');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundImage:
                _imageFile == null
                    ?AssetImage("assets/images/avatar.png") as ImageProvider
                    :FileImage(File(_imageFile!.path)),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        label: Text('Edit'),
                        backgroundColor: Colors.deepPurpleAccent,
                        icon: Icon(
                          Icons.edit,
                          size: 24.0,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomsheet()),
                        );
                          },
                      ),
                      SizedBox(width: 10,),
                      FloatingActionButton.extended(
                        label: Text('Save'),
                        backgroundColor: Colors.deepPurpleAccent,
                        icon: Icon(
                          Icons.save,
                          size: 24.0,
                        ),
                        onPressed: _imageFile != null ? uploadImage : null,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
    );
  }
  Widget bottomsheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Column(
        children: [
          Text(
            "Choisis une photo de profile",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: (){
                    takePhoto(ImageSource.camera);
                    uploadImage();
                  },
                  child: Column(
                    children: [
                      Icon(Icons.camera,color: Colors.deepPurpleAccent,),
                      Text("Camera",style: TextStyle(color: Colors.deepPurpleAccent,),)
                    ],
                  )
              ),
              SizedBox(width: 50),
              TextButton(
                  onPressed: (){
                    takePhoto(ImageSource.gallery);
                    uploadImage();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyDrawerHeader(profileImage: imageFile,)));
                  },
                  child: Column(
                    children: [
                      Icon(Icons.photo,color: Colors.deepPurpleAccent,),
                      Text("Gallery",style: TextStyle(color: Colors.deepPurpleAccent,),)
                    ],
                  )
              ),
            ],
          )
        ],
      ),
    ) ;
  }
  void takePhoto(ImageSource source) async{
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile= File(pickedFile!.path) ;
      // MyDrawerHeader(imageField: pickedFile!.path,);
      // print(" ----------------------path ${imageFile!.path}");
      // print("hello world");
      //widget.paths = toString(File(pickedFile!.path));
    });
  }
}
