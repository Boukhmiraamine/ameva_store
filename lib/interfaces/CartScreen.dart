import '../Modules/Cart.dart';
import '../Modules/CartBody.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  var total = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildAppBar(context),
        body: CartBody(),
        bottomNavigationBar: CheckOutCard(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Row(
        children: [
          SizedBox(
            child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
          ),
          SizedBox(width: 2,),
          Center(
            child: Column(
               children: [
                 Text("Votre panier", style: TextStyle(color: Colors.white),),
                 Text("${demoCart.length} produits", style: TextStyle(fontSize: 15,color: Colors.white),),
                ],
            )
          ),
        ],
      ),
    );
  }
}

class CheckOutCard extends StatelessWidget {
  CheckOutCard({Key? key}) : super(key: key);
  var total = 3297;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      //Demo height
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,-15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            ),
          ]
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "$total DH",
                        style: TextStyle(fontSize: 16, color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text("Valider le panier"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
