import 'dart:io';

import 'package:app11/interfaces/Admin/models/imagemodel.dart';

import '../models/productmodel.dart';
import '../models/productstatusmodel.dart';
import '../utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class ProductRepository{

  Future<List<ProductModel>> getProductsByStatus(String status);
  Future<bool> postStatus(ProductStatusModel input);
}

// 'Approved': 1,
// 'Sold': 2,
// 'Under_Review': 3,
// "Inactive": 4,
// "Deleted" : 5

class ProductService extends ProductRepository{ 
  @override
  Future<List<ProductModel>> getProductsByStatus(String status) async {
    List<ProductModel> productModels = <ProductModel>[
      ProductModel(product_id: 1,name: "Harry Potter I", slug: "L'école des sorciers",
      description: "Harry Potter, un jeune orphelin, est élevé par son oncle et sa tante qui le détestent. Alors qu il était haut comme trois pommes, ces derniers luiont raconté que ses parents étaient morts dans un accident de voiture.",
      price: "30",seller_id: 1,more_details: "",status: 1,category_id: 1,brand_id: 1,product_condition: 1,
      image: [ImageModel(url: "https://images.epagine.fr/652/9781408855652_1_75.jpg"),
              ImageModel(url: "https://www.babelio.com/couv/CVT_10230_671162.jpg"),
              ImageModel(url: "https://m.media-amazon.com/images/I/813JfJQwefL.jpg")])
    ];
    String url = getProductByStatus + status;
    try{
       var response = await http.get(Uri.parse(url));
       if(response.statusCode == 200){
         var jsonBody = convert.jsonDecode(response.body);
         var output = jsonBody["products"];
         if(output != null){
           output.forEach((e){
             productModels.add(ProductModel.fromJson(e));
           });
         }
       }
    }
    catch(e){
      print("error caught: $e");
    }
    return productModels;
  }

  @override
  Future<bool> postStatus(ProductStatusModel input) async {
    bool status = false;
    String url = productStatus;
    var jsoninput = convert.jsonEncode(input);
    try {
      var response = await http.post(Uri.parse(url),
                                     body: jsoninput,
                                     headers: {HttpHeaders.contentTypeHeader: "application/json"}
                                     );
      if (response.statusCode == 200) {
        var jsonBody = response.body;
        var output = convert.jsonDecode(jsonBody);
        var result = output["product"];
        if (result["status"] == "Successful") {
          status = true;
        }
      }
    } catch (e) {
      debugPrint("error caught: $e");
    }

    return status;
  }
  
}
