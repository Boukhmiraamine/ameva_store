
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'drawer.dart';
import '../utilis/constants.dart' as Constants;

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  HomeScreenState({this.tabController});

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  @override
  Widget build(BuildContext context) {
    var app = Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: TextStyle(color: textColor),),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.dashboard,color: Colors.black54,),),
            Tab(icon: Icon(Icons.assessment, color: Colors.black54,), text: 'STATUT',),

          ],
        ),
      ),
      drawer: MyDrawer(),
      body: Dashboard(tabController!),
    );
    return app;
  }
}