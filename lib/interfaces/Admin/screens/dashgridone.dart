import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/dashboardmodel.dart';
import '../services/dashboardrepo.dart';
import '../utilis/constants.dart' as Constants;

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}
//Add Proper amounts and percentages for Pie Chart
class PieChart2State extends State {
  DashboardModel dashboardModel = DashboardModel();
  var selectedDataSetIndex=-1;
  int? touchedIndex;
  @override
  void initState() {
    dashboardGet().then((data) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> dashboardGet() async {
    dashboardModel = await DashboardService().getAllDashboardData();
  }



  @override
  Widget build(BuildContext context) {
    var app = AspectRatio(
      aspectRatio: 1.3,
      child: ListView(

        scrollDirection: Axis.vertical,
        children: <Widget>[
        Column(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 20.0),
              //   alignment: Alignment.centerLeft,
              //   height: 20.0,
              //   child: Text(
              //     'General Status',
              //     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  
                  
              //     ),
              // ),
              Container(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(
                              /*  touchCallback: (FlTouchEvent Event,pieTouchResponse) {
                          setState(() {
                            if (!Event.isInterestedForInteractions ||
                                pieTouchResponse?.touchedSection is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse.touchedSection;
                            }
                          });
                        }),*/
                              touchCallback: (FlTouchEvent event, response) {
                                if (!event.isInterestedForInteractions) {
                                  setState(() {
                                    selectedDataSetIndex = -1;
                                  });
                                  return;
                                }
                                setState(() {
                                  touchedIndex =-1;

                                });
                              },
                            ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        sections: showingSections()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),
                   
                    //1
                    Row(
                      children: <Widget>[
                        Icon(Icons.devices, size: 30.0, color: Constants.card2),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Montant Total de Produit Vendu',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    //2
                    Row(
                      children: <Widget>[
                        Icon(Icons.chat_bubble,
                            size: 30.0, color: Constants.card3),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Total des Messages',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //3
                    Row(
                      children: <Widget>[
                        Icon(Icons.people, size: 30.0, color: Constants.card4),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Total des utilisateurs',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                     SizedBox(
                      height: 4,
                    ),
                    //4
                     Row(
                      children: <Widget>[
                        //Card1
                        Icon(Icons.euro_symbol,
                            size: 30.0, color: Constants.card1),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Montant Total des Produits',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                   
                    SizedBox(
                      height: 4,
                    ),

                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 28,
              ),
            ],
        ),],
      ),
    );
    Widget progress() {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return dashboardModel.totalApprovedProduct == null ? progress() : app;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 100 : 80;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Constants.card1,
            value: 45,
            title: '€ ' + dashboardModel.totalProductAmount.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          break;
        case 1:
          return PieChartSectionData(
            color: Constants.card2,
            value: 25,
            title: '€ ' + dashboardModel.totalSoldProductAmount.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          break;
        case 2:
          return PieChartSectionData(
            color: Constants.card3,
            value: 15,
            title: dashboardModel.totalMessage.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          break;
        case 3:
          return PieChartSectionData(
            color: Constants.card4,
            value: 15,
            title: dashboardModel.totalUser.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
          break;
        default:
          return PieChartSectionData(
            title: "NULL"
          );
      }
    });
  }
}
