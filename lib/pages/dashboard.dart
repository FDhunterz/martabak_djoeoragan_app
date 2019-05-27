import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/utils/Navigator.dart';
import 'package:martabakdjoeragan_app/pages/master.dart';
import 'package:martabakdjoeragan_app/pages/Pembelian/pembelian.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Kim Jisoo'),
                  accountEmail: Text('Jisoocu@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/jisoocu.jpg'),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xfffbaf18),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.view_list),
                  title: Text(
                    'Data  Master',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                      color: Color(0xff25282b),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    MyNavigator.goToMaster(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.view_list),
                  title: Text(
                    'Pembelian',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                      color: Color(0xff25282b),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    MyNavigator.goToPembelian(context);
                  },
                ),
              ],
            ),
          ),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 2,
              top: 23,
              child: IconButton(
                icon: Icon(Icons.menu),
                color: Color(0xff25282b),
                onPressed: () => scaffoldKey.currentState.openDrawer(),
              ),
            ),
            Positioned(
              child: Center(
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Color(0xff25282b),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
