import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/utils/Navigator.dart';
import 'tab_1.dart';
import 'tab_2.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    InventoryTab1(),
    InventoryTab2(),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 56, 70, 1),
          title: Text('Inventory'),
          actions: <Widget>[
            Material(
              // borderRadius: BorderRadius.all(Radius.circular(50.0)),  
              color: Color.fromRGBO(41, 56, 70, 1),
              child: InkWell(
              // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                onTap: (){

                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // borderRadius: BorderRadius.all(Radius.circular(50.0)),  
                  ),
                  child : Icon(Icons.person),
                ),
              ), 
            ),
          ],
          leading: Material( 
            color: Color.fromRGBO(41, 56, 70, 1),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (Route<dynamic> route) => false);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,  
                ),
                child : Icon(Icons.arrow_back),
              ),
            ), 
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset:Offset(0.0 ,0.0),
                blurRadius: 5,
                spreadRadius: 3,
              ),
            ]
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                title: Text('Laporan'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listAlt),
                title: Text('Data Stok'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.clipboard),
                title: Text('Opname'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ), 
      ),
    );
  }
}
