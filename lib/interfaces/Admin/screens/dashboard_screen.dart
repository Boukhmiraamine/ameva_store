import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../responsive.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Responsive(
        mobile: _buildMobileView(),
        desktop: _buildDesktopView(),
      ),
    );
  }

  Widget _buildMobileView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGridCards(),
        ],
      ),
    );
  }

  Widget _buildDesktopView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildGridCards(),
        ],
      ),
    );
  }





  Widget _buildUserCountCard() {
    return Card(
      color: Colors.cyan,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.white),),
      elevation: 10,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int userCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Number of Users : $userCount',
                          style: TextStyle(fontSize: 20.0, ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCountCard() {
    return Card(
      color: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.white),),
      elevation: 10,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int productCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shop),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Number of Products : $productCount',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }
  Widget _buildWaitingProductCountCard() {
    return Card(
      color: Colors.orangeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.white),),
      elevation: 10,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('waiting_products').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int waitingProductCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.watch_later),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child:  Text(
                          'Number of Waiting Products : $waitingProductCount',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExchangeHistoryCountCard() {
    return Card(
      color: Colors.pinkAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.white),),
      elevation: 10,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('exchanges').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int ExchangeHistoryCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.currency_exchange_outlined),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child:  Text(
                          'Number of Exchange Produts : $ExchangeHistoryCount',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridCards() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        // padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            int userCount = snapshot.data!.size;
            return GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(16.0),
              children: [
                _buildUserCountCard() ,
                _buildProductCountCard(),
                _buildWaitingProductCountCard(),
                _buildExchangeHistoryCountCard(),
              ],
            );
          },
        ),
      ),
    );
  }
}