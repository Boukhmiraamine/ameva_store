import 'package:flutter/material.dart';
import 'Modules/Product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}
class _ProductDetailState extends State<ProductDetail> {
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
          title: Text(widget.product.name),
        ),



        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.deepPurpleAccent),
                        shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        /***** name *****/
                        Column(
                          children: [
                            Text(
                              "Product name : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.product.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        /***** category *****/
                        Column(
                          children: [
                            Text(
                              "Category : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.product.category,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        /***** Price *****/
                        Column(
                          children: [
                            Text(
                              "Price : ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${widget.product.category} Dhs",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        /***** description *****/
                        Column(
                          children: [
                            Text(
                              "Description : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.product.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.8, 0, 0.8, 0.8),
                      child: SizedBox(
                        width: 150,
                        height: 30,

                        child: ElevatedButton(
                            style: ButtonStyle(


                                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.add_circle_outlined),
                                  Text(" Add to panner")
                                ],
                              )),
                        ),

                      ),
                    ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



