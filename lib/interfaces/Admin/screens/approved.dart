import '../models/imagemodel.dart';
import '../models/productmodel.dart';
import 'drawer.dart';
//import 'package:app_drawer/screens/product.dart';
import 'productsother.dart';
import '../services/productrepo.dart';
//import 'package:app_drawer/utilis/trimName.dart';
import '../widgets/utilwidgets.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import '../utilis/constants.dart' as Constants;

class ApprovedProducts extends StatefulWidget {
  @override
  _ApprovedProductsState createState() => _ApprovedProductsState();
}

class _ApprovedProductsState extends State<ApprovedProducts> {
  List<ProductModel> productModels = <ProductModel>[
    ProductModel(product_id: 1,name: "Harry Potter I", slug: "L'école des sorciers",
        description: "Harry Potter, un jeune orphelin, est élevé par son oncle et sa tante qui le détestent. Alors qu il était haut comme trois pommes, ces derniers luiont raconté que ses parents étaient morts dans un accident de voiture.",
        price: "30",seller_id: 1,more_details: "Le jour de ses onze ans, Harry Potter, un orphelin élevé par un oncle et une tante qui le détestent, voit son existence bouleversée. Un géant vient le chercher pour l'emmener à Poudlard, une école de sorcellerie! Voler en balai, jeter des sorts, combattre les trolls : Harry Potter se révèle un sorcier doué. Mais un mystère entoure sa naissance et l'effroyable V..., le mage dont personne n'ose prononcer le nom. Amitié, surprises, dangers, scènes comiques, Harry découvre ses pouvoirs et la vie à Poudlard. Le premier tome des aventures du jeune héros vous ensorcelle aussitôt!",
        status: 1,category_id: 1,brand_id: 1,product_condition: 1,
        image: [ImageModel(url: "https://m.media-amazon.com/images/I/813JfJQwefL.jpg"),
          ImageModel(url: "https://www.babelio.com/couv/CVT_10230_671162.jpg"),
          ImageModel(url: "https://images.epagine.fr/652/9781408855652_1_75.jpg")])
  ];

  @override
  void initState() {
    productGet().then((data) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> productGet() async {
    productModels = (await (List<ProductModel>)) as List<ProductModel>; ProductService().getProductsByStatus("1");
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).accentColor;
    Color textColor = Constants.textColor;

    var app = Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          'Produits Aprouvés',
          style: TextStyle(color: textColor),
        ),
      ),
      drawer: MyDrawer(),
      body:  getProductList(),
    );
    return app;
  }

  Widget getProductList() {

      var app = GridView.builder(
          itemCount: productModels.length == null ? 0 : productModels.length,
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            ProductModel productModel = ProductModel();
            productModel = productModels[index];
            //var name = TrimName.checkNameLength(productModel.name);
            var name = productModel.name;
            if (name!.length <= 18) {
              name = productModel.name?.toUpperCase();
            } else {
              name = trimProductName(name!);
            }
            List<dynamic> imageUrls = <dynamic>[];
            productModel.image?.forEach((i) {
              if (i.url == "")
                imageUrls.add(
                    NetworkImage('https://i.ibb.co/hDFyMGH/temp.jpg'));
              else {
                imageUrls.add(NetworkImage(i.url!));
              }
            });


            return Padding(
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsOther(productModel),
                    ),
                  );
                },
                child: Card(
                  elevation: 8.0,
                  child: Hero(
                    tag: index,
                    child: GridTile(
                      footer: Container(
                        color: Colors.white70,
                        height: 50.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(name!),
                            Text('€ ' + productModel.price!)
                          ],
                        ),
                      ),
                      child: Carousel(
                        images: imageUrls,
                        autoplay: false,
                        dotSize: 1,
                      )
                      /*FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: productModel.image.first.url,
                      fit: BoxFit.fitHeight,
                    )*/
                      ,
                      // child: Image.asset(
                      //   'images/admin.png',
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                  ),
                ),
              ),
            );
          });

    return productModels.length == 0 ? UtilWidgets.gridProgress() : app;

  }

  String trimProductName(String title) {
    var result = title.substring(0, 16).toUpperCase() + '...';
    return result;
  }
}
