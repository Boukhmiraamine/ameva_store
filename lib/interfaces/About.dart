import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Ameva'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'About Ameva',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Ameva is a revolutionary mobile application for exchanging used furniture between individuals. It connects people who want to donate or exchange their used furniture with those who need it. With Ameva, users can easily publish listings, contact sellers, and arrange furniture pick-up or delivery. The app's mission is to promote sustainability by reducing waste and making sustainable living accessible to everyone. Ameva is the perfect platform for individuals and families looking to breathe new life into their beloved furniture. The app is user-friendly, secure and provides a seamless experience for both buyers and sellers. Join Ameva now and be part of the movement towards a more sustainable future!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Email: amevaameva2023@gmail.com\nPhone: +212 671 18 11 46\nAddress: Universiapolis, Agadir, MOROCCO',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.control_point),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.control_point),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
