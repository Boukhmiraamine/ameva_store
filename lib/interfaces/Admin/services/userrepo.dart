import 'dart:convert' as convert;
import '../models/usermodel.dart';
import '../utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository{
  Future<List<UserModel>> getAllUsers();
}

class UserService extends UserRepository{

  @override
  Future<List<UserModel>> getAllUsers() async {
    String url = getUsers;
    List<UserModel> userModel = <UserModel>[];
    try{
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200){
          var jsonBody = convert.jsonDecode(response.body);
          var output = jsonBody["users"];
          if(output != null){
          output.forEach((e){          
            userModel.add(UserModel.fromJson(e));
          });
        }       
        }

    }
    catch(e){
      debugPrint("error caught: $e");
    }
    return userModel;
  }

}