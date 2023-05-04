
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'drawer.dart';
import '../utils/constants.dart' as Constants;

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


  @override
  Widget build(BuildContext context) {
    var app = Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
       /* bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.dashboard,color: Colors.black54,),),
            Tab(icon: Icon(Icons.assessment, color: Colors.black54,), text: 'STATUT',),

          ],
        ), */
      ),
      drawer: MyDrawer(),
      body: DashboardScreen(),
      //Dashboard(tabController!),
    );
    return app;
  }
}