import 'package:app11/interfaces/CartScreen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../Modules/Cart.dart';
import '../Modules/Product.dart';
import '../ProductDetail.dart';
import '../filtering.dart';
import '../item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var listProduct = [


    Product(
      decription: "decription2",
      image: "assets/images/products/chaise2.jpg",
      name: "chaise",
      price: "250",
      category: "Bureautique",
    ),

   /* Product(
      decription: "decription3",
      image: "assets/images/products/sac.jpg",
      name: "sac",
      price: "20",
      category: "Bureautique",
    ),*/

   /* Product(
      decription: "decription4",
      image: "assets/images/products/calcul.jpg",
      name: "calculatrice",
      price: "20",
      category: "Bureautique",
    ),*/
    Product(
      decription: "decription5",
      image: "assets/images/products/table3.jpg",
      name: "table",
      price: "499",
      category: "Bureautique",
    ),
    Product(
      decription: "decription5",
      image: "assets/images/products/phone.jpeg",
      name: "Pochette noir",
      price: "30",
      category: "Phones",
    ),


    Product(
      decription: "decription5",
      image: "assets/images/products/chaise.jpeg",
      name: "chaise",
      price: "500",
      category: "Bureautique",
    ),
    Product(
      decription: "decription5",
      image: "assets/images/products/clavier.jpg",
      name: "Clavier",
      price: "200",
      category: "Bureautique",
    ),


    Product(
      decription: "decription5",
      image: "assets/images/products/lampe.jpeg",
      name: "Lampe",
      price: "199",
      category: "Bureautique",
    ),
    Product(
      decription: "decription5",
      image: "assets/images/products/sac3.jpeg",
      name: "sac",
      price: "205",
      category: "Bureautique",
    ),
    Product(
      decription: "decription5",
      image: "assets/images/products/souris.png",
      name: "souris",
      price: "150",
      category: "Bureautique",
    ),

    Product(
      decription: "decription5",
      image: "assets/images/products/phone2.jpeg",
      name: "Pochette couleur",
      price: "40",
      category: "Phones",
    ),

    /*Product(
      decription: "decription5",
      image: "assets/images/products/table3.jpg",
      name: "table",
      price: "20",
      category: "Phones",
    ),*/
    Product(
      decription: "decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 decription5 ",
      image: "assets/images/products/airepods.jpg",
      name: "AirPods",
      price: "299",
      category: "Phones",
    ),
    Product(
      decription: "decription1",
      image: "assets/images/products/product.jpeg",
      name: "Sac à dos ",
      price: "99",
      category: "Bureautique",

    ),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Bike.jpg",name: "Bike",price: "10",category: "Transport",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Trotinette.jpg",name: "Trotinette",price: "20",category: "Transport",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Car.jpg",name: "Car",price: "4580",category: "Transport",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Samsung_S20.jpg",name: "Samsung S20",price: "30",category: "Phones",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Iphone_14.jpeg",name: "Iphone 14",price: "240",category: "Phones",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Nokia_pile.jpeg",name: "Nokia pile",price: "2055",category: "Phones",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Redmi_8.jpeg",name: "Redmi 8",price: "274",category: "Phones",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Table.jpg",name: "Table",price: "204",category: "Bureautique",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/Laptop.jpg",name: "Laptop",price: "2040",category: "Bureautique",),
    Product(decription: "Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 Decription1 ",image: "assets/images/products/HDMI.jpg",name: "HDMI_Cable",price: "254",category: "Bureautique",),





  ];
  List<Product> get _listProduct => listProduct;


  bool _showSearchBar = false;
  String _searchText = '';
  var searchIcon = Icon(Icons.search);
  var cancelIcon = Icon(Icons.cancel);

  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = listProduct;
  }

  void _filterProducts(value) {
    setState(() {
      _searchText = value;
      _filteredProducts = listProduct.where((product) {
        return product.name.toUpperCase().contains(_searchText.toUpperCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_showSearchBar
            ? Text("Ameva Store",style: TextStyle(fontSize: 24),)
            : TextField(
                autofocus: true,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  //hoverColor: Colors.green,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,

                  hintText: "Search for a product ...",

                ),
                onChanged: _filterProducts),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: searchIcon,
            onPressed: () {
              setState(() {
                /* if(searchIcon == searchIcon){
                  searchIcon = cancelIcon;
                }else if (cancelIcon == cancelIcon){
                  cancelIcon = searchIcon;
                }*/
                _showSearchBar = !_showSearchBar;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Badge(
              position: BadgePosition.topEnd(top: 1, end: 1),
              child: Card(
                borderOnForeground: false,
                color: Colors.deepPurple,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => CartScreen()));
                      setState(() {});
                    },
                    icon:  Icon(Icons.shopping_cart,size: 30,),
                    // color: colorFav,
                  ),
                ),
              ),
              badgeContent: SizedBox(
                  width: 20,
                  height: 20,
                  child:Center(
                    child:Text("${demoCart.length}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        setState(() {

                          Navigator.push(context, MaterialPageRoute( builder: (context)
                          {

                            return FiltringProduct(product: listProduct);
                          }));
                        });
                      },
                      icon: Icon(
                        Icons.filter_list_rounded,
                        size: 40,
                        color: Colors.deepPurple,
                      )))),
          SizedBox(height: 20,),
          Expanded(
            flex: 24,
            child: GridView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ProductItem(_filteredProducts[index]),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(product: listProduct[index])),
                      );
                    });
                  },
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                mainAxisExtent: 330,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
