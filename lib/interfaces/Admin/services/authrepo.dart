import 'dart:convert' as convert;
import 'dart:io';
import '../models/authmodel.dart';
import '../utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<bool> authUser(AuthModel input);
}

class AuthServices extends AuthRepository {

 // LoginState loginState = LoginState();
  
  @override
  Future<bool> authUser(AuthModel input) async {
    bool result = false;
    String baseurl = authAdminUrl;
    try {
      var response = await http.post(Uri.parse(baseurl),
          body: convert.jsonEncode(input),
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
      if (response.statusCode == 200) {
        var jsonBody = response.body;
        var output = convert.jsonDecode(jsonBody);
        if (output["status"] == "sucessfull") {
          result = true;
          addUser(output["user_name"]);
        }
      }
    } catch (e) {
      print("error caught: $e");
    }
    return result;
  }

  Future<void> addUser(String user_name) async {
   // await loginState.storage.write(key: "token2", value: user_name);
  }
}
