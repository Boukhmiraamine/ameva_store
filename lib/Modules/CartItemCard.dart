import '../Modules/Cart.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(aspectRatio: 0.88,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(image: cart.product.image),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((cart.product.name), style: TextStyle(fontSize: 16, color: Colors.black,), maxLines : 2),
            const SizedBox(height: 10,),
            Text.rich(
              TextSpan(text: "${cart.product.price}", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orangeAccent),
                children: [
                  TextSpan(
                      text: " x${cart.numOfItems}",
                      style: TextStyle(color: Colors.blueGrey)
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}