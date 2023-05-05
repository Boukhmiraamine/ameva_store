import 'package:app11/Modules/Product.dart';
import 'package:flutter/material.dart';


class SendRequestPage extends StatefulWidget {
  final Product product;

  const SendRequestPage({Key? key, required this.product}) : super(key: key);
  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}
class _SendRequestPageState extends State<SendRequestPage> {
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
                                Text(" Send")
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



