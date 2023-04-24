import 'package:app11/Modules/Product.dart';
import 'package:flutter/material.dart';

Widget ProductItem(Product Product) {
  return Card(
    color: Colors.grey[300],
    shape: RoundedRectangleBorder(
      side: BorderSide(

        width: 2,
        color: Colors.deepPurple.shade300,

      ),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Container(
        height: 500,
        width: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black45),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(
                      Product.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
             Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Product.name,
                        style: TextStyle(
                            fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      Text(

                        "Category: #${Product.category}",
                        style: TextStyle(
                            fontSize: 15, color: Colors.black54,fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(

                            "            Price : ",
                            style: TextStyle(fontSize: 19),

                          ),
                          Text(

                            "${Product.price} Dhs",
                            style: TextStyle(fontSize: 19, color: Colors.red,fontWeight: FontWeight.bold),


                          ),
                        ],
                      ),


                    ],
                  ),
                )
              ],
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.8, 0, 0.8, 0.8),
                  child: SizedBox(

                    width: 170,
                    height: 40,


                    child: ElevatedButton(

                        style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade300),
                        ),
                        onPressed: () {


                        },
                        child: Row(
                          children: [
                            Icon(Icons.add_circle_outlined),
                            Text(" Add to panner" ,style: TextStyle(fontSize: 17))
                          ],
                        )),
                  ),
                ),
              ),
            )
          ],
        )),
  );
}
