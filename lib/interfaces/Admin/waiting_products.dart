import 'package:app11/interfaces/Admin/screens/drawer.dart';
import 'package:app11/interfaces/Admin/waiting_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Modules/Product.dart';


import 'item_waiting_products.dart';

class waiting_products extends StatefulWidget {
  const waiting_products({Key? key}) : super(key: key);

  @override
  State<waiting_products> createState() => _waiting_productsState();
}

class _waiting_productsState extends State<waiting_products> {
  List<Product> listProduct = [];

  Future<void> getProducts() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('waiting_products').get();

    listProduct = snapshot.docs.map((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      return Product(
        name: data!['name'],
        description: data!['description'],
        image: data!['image'],
        category: data!['category'],
        publication_date: data!['publication_date'],
      );
    }).toList();
  }

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
            ? Text(
          "Ameva Store",
          style: TextStyle(fontSize: 24),
        )
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
        ],
      ),
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return FiltringProduct(product: listProduct);
                              }));*/
                        });
                      },
                      icon: Icon(
                        Icons.filter_list_rounded,
                        size: 40,
                        color: Colors.deepPurple,
                      )))),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 15,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('waiting_products')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.data!.size==0) {
                      return Center(child: Text("No waiting products."),);
                    }
                    else {

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final products = snapshot.data!.docs
                          .map((doc) => Product.fromSnapshot(doc))
                          .toList();

                      return GridView.builder(
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = products[index];

                            return GestureDetector(
                              child: item_waiting_products(product, context),
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AWProductDetail(product: product)),
                                  );
                                });
                              },
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            mainAxisExtent: 330,
                          ));
                    }
                  }
                  else{
                    return Center(child: Text("Could not access data.", style: TextStyle(color: Colors.red),),);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
