import 'dart:io';
import '../models/categorymodel.dart';
import '../utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class CategoryRepository{
  Future<List<CategoryModel>> getAllCategoryData();
  Future<bool> addCategory(CategoryModel input); 
}


class CategoryService extends CategoryRepository{
  String url = getSubCategories;
  @override
  Future<List<CategoryModel>> getAllCategoryData() async {
    List<CategoryModel> categoryModels = <CategoryModel>[
      CategoryModel(name: "Livre", description: "Un livre est un document écrit formant unité et conçu comme tel, composé de pages reliées les unes aux autres. Il a pour fonction d'être un support de l'écriture, permettant la diffusion et la conservation de textes de nature variée.", parent_id: 1)
    ];
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var jsonBody = convert.jsonDecode(response.body);
        var output = jsonBody["rows"];
        if(output != null){
          output.forEach((e){          
            categoryModels.add(CategoryModel.fromJson(e));
          });
        }
        
      }
    }
    catch(e){
      print("error caght: $e");
    }
    return categoryModels;
  }

  @override
  Future<bool> addCategory(CategoryModel input) async {
    bool status = false; 
    String url = postCategory;
    var jsoninput = convert.jsonEncode(input);
    try{
    var response = await http.post(Uri.parse(url),
                                   body: jsoninput, 
                                   headers: {
                                     HttpHeaders.contentTypeHeader: "application/json"
                                   });
    if(response.statusCode == 200){
      var jsonBody = response.body;
      var output = convert.jsonDecode(jsonBody);
      var result = output["products"];
      if(result != null){
        status = true;
      }
    }
    }catch(e){
     print("error caught: $e");
    }

    return status;
  }

}
