import 'package:app11/FirstInterface.dart';
import 'package:app11/Modules/Product.dart';

import 'package:flutter/material.dart';

import 'Interfaces/Home.dart';

class FiltringProduct extends StatefulWidget {
  final List<Product> product;


  const FiltringProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<FiltringProduct> createState() => _FiltringProductState();
}

class _FiltringProductState extends State<FiltringProduct> {
  late String _selectedCategory = "Phones";
  late double maxPrice;
  late RangeValues _selectedPrice;

  @override
  void initState() {
    super.initState();
    maxPrice = widget.product
        .map((product) => double.parse(product.category))
        .reduce((value, element) => value > element ? value : element);
    _selectedPrice = RangeValues(0, maxPrice);
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Filtring Products Page"),
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image(image: AssetImage("images/filtring.png",),height: 300,width: 400,),
              Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurpleAccent),
                      shape: BoxShape.rectangle,

                    ),
                    child: Column(
                      children: [

                        /***** Category :*****/
                        Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Text("Category :",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              )),



                        ),
                        Text(_selectedCategory,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54,
                              fontStyle: FontStyle.normal,
                            )),

                        RadioListTile(

                          title: Text('Phones'),
                          value: 'Phones',
                          groupValue: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('Bureautique'),
                          value: 'Bureautique',
                          groupValue: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('Transport'),
                          value: 'Transport',
                          groupValue: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),

                        /******* range price ******/

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Price :",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        Text(
                            "Price Range ${_selectedPrice.start.toInt()} Dhs - ${_selectedPrice.end.toInt()} Dhs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54,
                              fontStyle: FontStyle.normal,
                            )),
                        RangeSlider(
                          values: _selectedPrice,
                          min: 0,
                          max: maxPrice,
                          onChanged: (RangeValues newValues) {
                            setState(() {
                              _selectedPrice = newValues;
                            });
                          },
                        ),


                      ],
                    ),
                  ),
                  /*Container(
                    child:   Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 55,
                        width: 155,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              print("${_selectedCategory}");
                              print("${widget.product.map((product) => double.parse(product.price)).reduce((value, element) => value > element ? value : element)}");
                              print(
                                  "${_selectedPrice.start.toInt()} DH - ${_selectedPrice.end.toInt()} DH");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => filtredproduct(price : _selectedPrice, category : _selectedCategory, list : widget.product )),
                              );
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("SUBMIT",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,

                                  )),
                              SizedBox(width: 10),
                              Icon(Icons.done,
                                  size: 35, color: Colors.white),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),)*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

