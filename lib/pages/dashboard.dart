import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/utils/Navigator.dart';
import 'package:martabakdjoeragan_app/pages/master.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
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
                Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => MasterPage()));
                },
            ),
          ],
        ),
      )
    );
  }
}
