import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:app11/mydrawerheader.dart';


class ProfileImage extends StatefulWidget {
  ProfileImage({Key? key}) : super(key: key);

  // late final String? paths;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? imageFile ;
  final ImagePicker _picker = ImagePicker() ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundImage:
                imageFile == null
                    ?AssetImage("assets/images/avatar.png") as ImageProvider
                    :FileImage(File(imageFile!.path)),
              ),
              Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.symmetric(horizontal: 0.0,vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit,color: Colors.white,),
                      TextButton(
                        onPressed: (){
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomsheet()),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.deepPurpleAccent.withOpacity(0.38), // Disable color
                        ),
                        child: const Text(
                          'Edit ',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  )
                ),
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
      imageFile= File(pickedFile!.path) ;
      // MyDrawerHeader(imageField: pickedFile!.path,);
      // print(" ----------------------path ${imageFile!.path}");
      // print("hello world");
      //widget.paths = toString(File(pickedFile!.path));
    });
  }
}
