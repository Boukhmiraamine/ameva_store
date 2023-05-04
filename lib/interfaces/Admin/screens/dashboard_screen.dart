//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fl_chart/fl_chart.dart';
//import '../responsive.dart';

/*class DashboardScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget bottomTitlesWidgets(double value, TitleMeta meta){
  const style= TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14);
  String text=value.toInt() as String;
  text=text + 'month';
  return FittedBox(child: Text(text, style: style, textAlign: TextAlign.center,),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: _buildMobileLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserCountCard(),
          _buildProductCountCard(),
          _buildWaitingProductCountCard(),
          _buildProductAddedChart(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildUserCountCard(),
                _buildProductCountCard(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildWaitingProductCountCard(),
                _buildProductAddedChart(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserCountCard() {
    return Card(
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
                Text(
                  'Nombre d\'utilisateurs : $userCount',
                  style: TextStyle(fontSize: 20.0),
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
                Text(
                  'Nombre de produits : $productCount',
                  style: TextStyle(fontSize: 20.0),
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
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('waiting_product').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int waitingProductCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre de produits en attente : $waitingProductCount',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductAddedChart() {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<Map<String, dynamic>> data = [];

            /*for (var doc in snapshot.data!.docs) {
              //Timestamp timestamp = doc['publication_date'];
              /*DateTime date =
              DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);*/
              Timestamp timestamp = Timestamp.fromDate(DateTime.parse(doc['publication_date']));
              DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
              String month = '${date.year.toString()}-${date.month.toString()}';
              int index = data.indexWhere((item) => item['month'] == month);

              if (index >= 0) {
                data[index]['count']++;
              } else {
                data.add({'month': month, 'count': 1});
              }
            }*/
            for (var doc in snapshot.data!.docs) {
              //Timestamp timestamp = Timestamp.fromDate(DateTime.parse(doc['publication_date']));
              Timestamp timestamp = doc['publication_date'];
              //DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
              DateTime date = timestamp.toDate();
              String month = '${date.year.toString()}-${date.month.toString()}';
              int index = data.indexWhere((item) => item['month'] == month);

              if (index >= 0) {
                data[index]['count']++;
              } else {
                data.add({'month': month, 'count': 1});
              }
            }


            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre de produits ajoutés par mois',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                AspectRatio(
                  aspectRatio: 1.7,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 6,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                         /* margin: 20,
                          rotateAngle: 45,*/
                         /* getTextStyles: (BuildContext context, double v) {
                        return  const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14);
          },
                          getTitles: (double value) {
                            return data[value.toInt()]['month'];
                          },*/
                          getTitlesWidget: bottomTitlesWidgets,
                        ),
                        ),
                        leftTitles: AxisTitles (
                            sideTitles: SideTitles(showTitles: false),
            )
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: data
                          .asMap()
                          .map((key, value) =>
                          MapEntry(
                              key,
                              BarChartGroupData(
                                x: key,
                                barRods: [
                                  BarChartRodData(
                                    toY: value['count'].toDouble(),
                                    //colors: [Colors.blueAccent],
                                    color: Colors.blueAccent,
                                  )
                                ],
                                showingTooltipIndicators: [0],
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}*/
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
          _buildUserCountCard(),
          _buildProductCountCard(),
          _buildWaitingProductCountCard(),
          _buildExchangeHistoryCard(),
        ],
      ),
    );
  }

  Widget _buildDesktopView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildUserCountCard(),
              _buildProductCountCard(),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildWaitingProductCountCard(),
              _buildExchangeHistoryCountCard(),
            ],
          ),
        ),
      ],
    );
  }




  Widget _buildExchangeHistoryCard() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique des échanges'),
          ),
         /* AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: exchangeHistory
                        .asMap()
                        .entries
                        .map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.toDouble());
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
  Widget _buildUserCountCard() {
    return Card(
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
                Icon(Icons.person),
                Text(
                  'Nombre d\'utilisateurs : $userCount',
                  style: TextStyle(fontSize: 20.0),
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
                Icon(Icons.shop),
                Text(
                  'Nombre de produits : $productCount',
                  style: TextStyle(fontSize: 20.0),
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
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('waiting_product').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int waitingProductCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.watch_later),
                Text(
                  'Nombre de produits en attente : $waitingProductCount',
                  style: TextStyle(fontSize: 20.0),
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
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('exchange').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            int ExchangeHistoryCount = snapshot.data!.size;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre de produits échangé : $ExchangeHistoryCount',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
