import 'dart:math';

import '../models/categorymodel.dart';
import 'drawer.dart';
import 'subcategory.dart';
import '../services/categoryrepo.dart';
import 'package:flutter/material.dart';
import '../utilis/constants.dart' as Constants;

class CategoryAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryAdminState();
  }
}

class CategoryAdminState extends State<CategoryAdmin> {
  List<CategoryModel> categoryModel = <CategoryModel>[
    CategoryModel(category_id: 1,name: "Livre", description: "Un livre est un document écrit formant unité et conçu comme tel, composé de pages reliées les unes aux autres. Il a pour fonction d'être un support de l'écriture, permettant la diffusion et la conservation de textes de nature variée.",
        parent_id: 0),


  ];

  @override
  void initState() {
    categoryGet().then((data) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> categoryGet() async {
    categoryModel = (await(List<CategoryModel>)) as List<CategoryModel>; CategoryService().getAllCategoryData();
  }

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  Color btnColor = Constants.btnColor;
  @override
  Widget build(BuildContext context) {
    var app = Scaffold(

      appBar: AppBar(
        title: Text(
          'Categoris',
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: secColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: secColor, size: 30.0),
        onPressed: () {
          Navigator.of(context).pushNamed('/addCat');
        },
        tooltip: 'Add new Category',
        
      ),
      drawer: MyDrawer(),
      body: getCategoryList(),
    );
    return app;
  }

  ListView getCategoryList() {
    var app = ListView.builder(
        itemCount: categoryModel.length == null ? 0 : categoryModel.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 70.0,
            margin: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                debugPrint(categoryModel[index].sub_category!.length.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SubCategory(subcategoryModel:categoryModel[index].sub_category, categoryid: categoryModel[index].category_id,);
                }));
              },
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                leading: CircleAvatar(
                    backgroundColor: Constants.btnColor,
                    radius: 23.0,
                    child: Text(getTitle(categoryModel[index].name!), style: TextStyle(color: Colors.white))),
                title: Text(categoryModel[index].name!),
                subtitle: Text(categoryModel[index].description!),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        });
    return app;
  }

  String getTitle(String title) {
    var result = "";
    return result = title.substring(0, 2);
  }
}
