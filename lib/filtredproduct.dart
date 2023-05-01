import 'package:app11/ProductDetail.dart';
import 'package:app11/item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Modules/Product.dart';

class filtredproduct extends StatefulWidget {
  final RangeValues price;
  final String category;
  final List<Product> list;
  const filtredproduct({Key? key, required this.price, required this.category, required this.list}) : super(key: key);

  @override
  State<filtredproduct> createState() => _filtredproductState();
}

class _filtredproductState extends State<filtredproduct> {
  late List<Product> _filteredList;

  @override
  /*void initState() {
    super.initState();
    _filteredList = widget.list
        .where((product) => (double.parse(product.price) >= widget.price.start && double.parse(product.price) <= widget.price.end))
        .where((product) => product.category == widget.category)
        .toList();
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Filtred Products"),

        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: GridView.builder(
                  itemCount: _filteredList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: ProductItem(_filteredList[index]),
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(product: _filteredList[index])),
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
        ),
      ),
    );
  }
}