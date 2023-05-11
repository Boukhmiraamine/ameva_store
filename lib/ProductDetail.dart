import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Modules/Product.dart';
import 'MyProductsOnly.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  String readTimestamp(Timestamp timestamp) {
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

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
          title: Text("Product Details"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Center(
            child: Container(
            height: 500,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepPurpleAccent),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          /***** name *****/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.product.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              /***** date *****/
              Text("${widget.readTimestamp(widget.product.publication_date)}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Category: #${widget.product.category}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('products').doc(widget.product.id).get(),
                  builder: (context, productSnapshot) {
                    if (!productSnapshot.hasData) {
                      return Text('Loading...');
                    }

                    var productData = productSnapshot.data!.data() as Map<String, dynamic>;
                    var userId = productData['user_id'];

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return Text('Loading...');
                        }

                        var userData = userSnapshot.data!.data() as Map<String, dynamic>;
                        var firstName = userData['first name'];
                        var lastName = userData['last name'];

                        return Text(
                          "by: ${firstName ?? ''} ${lastName ?? ''}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          /***** description *****/
          Text("Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.deepPurple[300],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            height: 400,
            width: 500,
            constraints: BoxConstraints(
              maxHeight: 300,
              maxWidth: 400,
            ),
            decoration: BoxDecoration(
            color: Color(0xE6D1FFF),
            borderRadius: BorderRadius.circular(10),
            ),
          child: Text(
            '${widget.product.description}',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          //SizedBox(height: 200,),
          ),
            ]
           ),
          ),
        ),
         floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade300,
            onPressed: (){
              print("****************************************");
              print("..${widget.product.id}");
              print("****************************************");
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyProductsOnly(targetProduct:widget.product)),
              );
            },
            child: Icon(Icons.send),
          ),
      ),
    );
  }
}