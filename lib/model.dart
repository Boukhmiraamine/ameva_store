// import 'package:app11/interfaces/Admin/models/usermodel.dart';

class UserModel {
  String? uid;
  String? email;
  String? wrool;
  String? fullName;



//receiving data
  UserModel({this.uid, this.email, this.wrool,this.fullName});
  /*factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      wrool: map['wrool'],
      fullName: map['fullName'],
    );
  }*/
  UserModel.fromJson(Map<dynamic,dynamic>map){
    if(map==null){
      return;
    }
    uid=map['uid'];
    email=map['email'];
    wrool=map['wrool'];
    fullName=map['fullName'];

  }
toJson(){
    return{
      'uid': uid,
      'email': email,
      'wrool': wrool,
      'fullName': fullName,

    };

}

  //sending data
  /*Map<String,dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'wrool': wrool,
    };

  }*/
}