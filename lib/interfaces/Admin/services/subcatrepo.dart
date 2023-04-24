import '../models/categorymodel.dart';
import '../utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class SubCategoryRepository{
  Future<List<CategoryModel>> getAllSubCategoryData();
}


class SubCategoryService extends SubCategoryRepository{
  String url = getSubCategories;
  @override
  Future<List<CategoryModel>> getAllSubCategoryData() async {
    List<CategoryModel> subcategoryModels = <CategoryModel>[];
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var jsonBody = convert.jsonDecode(response.body);
        var output = jsonBody["rows"];
        if(output != null){
          output.forEach((e){
            
            subcategoryModels.add(CategoryModel.fromJson(e));
          });
          //categoryModels = output.map((e) => CategoryModel.fromJson(e)).toList();
          //categoryModels = output.map((e) => CategoryModel.fromJson(convert.jsonDecode(e)));
        }
        
      }
    }

    catch(e){
      debugPrint("error caught: $e");
    }
    return subcategoryModels;
  }

}
